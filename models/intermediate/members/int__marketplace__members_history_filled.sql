{{ config(materialized='table') }}

WITH gap_fill_created_members AS (
    SELECT
        *
    FROM
        GAP_FILL(
            (SELECT * FROM {{ ref('int__marketplace__members_history') }}),
            ts_column => 'seeker_profile_created_at',
            bucket_width => INTERVAL 1 DAY,
            partitioning_columns => ['seeker_id', 'user_id', 'member_primary_type',  'user_situation', 'ambassador_company_name','company_sector_name','address_country','address_administrative_area_level_1_region_fr','address_administrative_area_level_2_department_fr','address_city_fr', 'address_postal_code'],
            value_columns => [
                ('member_is_created','null')
            ]
        )
),

soft_deleted_members AS (
    SELECT
        seeker_id,
        MIN(user_soft_deleted_at) AS user_soft_deleted_at
    FROM
        {{ ref('base__marketplace__seekers') }} AS seekers
    INNER JOIN
        {{ ref('base__marketplace__users') }} AS users
        USING(user_id)
    GROUP BY ALL
)

SELECT
    COALESCE(gap_fill_created_members.seeker_id, activation.seeker_id) AS seeker_id,
    COALESCE(gap_fill_created_members.seeker_profile_created_at, DATE(activation.member_activated_at)) AS measured_at,
    gap_fill_created_members.* EXCEPT(seeker_id, seeker_profile_created_at),
    activation.user_id IS NOT NULL AS member_is_activated,
    CASE
        WHEN incomplete_profile.seeker_id IS NOT NULL THEN 'member_profile_is_incomplete'
        WHEN soft_deleted_members.seeker_id IS NOT NULL THEN 'member_is_soft_deleted'
        WHEN members_activation.seeker_id IS NOT NULL THEN 'member_is_activated'
        WHEN members_deactivation.seeker_id IS NOT NULL THEN 'member_is_not_activated'
        ELSE 'other'
    END AS member_activation,
    IF(
        user_is_currently_involved_in_a_fdr OR user_is_all_time_involved_in_a_fdr,
        'member_affiliated',
        'member_non_affiliated'
    ) AS member_affiliation,
    {{ member_secondary_type(
        'member_primary_type',
        'user_situation',
        'ambassador_is_published'
    ) }} AS member_secondary_type
FROM
    gap_fill_created_members
FULL OUTER JOIN
    {{ ref('int__marketplace__members_activation') }} AS activation
    ON DATE(gap_fill_created_members.seeker_profile_created_at) = DATE(activation.member_activated_at)
    AND activation.seeker_id = gap_fill_created_members.seeker_id
LEFT JOIN
    soft_deleted_members
    ON gap_fill_created_members.seeker_id = soft_deleted_members.seeker_id
    AND DATE(gap_fill_created_members.seeker_profile_created_at) >= DATE(user_soft_deleted_at)
LEFT JOIN
    {{ ref('int__marketplace__members_activation') }} AS members_activation
    ON gap_fill_created_members.seeker_id = members_activation.seeker_id
    AND DATE(gap_fill_created_members.seeker_profile_created_at) >= DATE(members_activation.member_activated_at)
LEFT JOIN
    {{ ref('int__marketplace__members_activation') }} AS members_deactivation
    ON gap_fill_created_members.seeker_id = members_deactivation.seeker_id
    AND (DATE(gap_fill_created_members.seeker_profile_created_at) <= DATE(members_deactivation.member_activated_at) OR members_deactivation.member_activated_at IS NULL)
LEFT JOIN
    {{ ref('base__marketplace__seekers') }} AS incomplete_profile
    ON gap_fill_created_members.seeker_id = incomplete_profile.seeker_id
    AND DATE(gap_fill_created_members.seeker_profile_created_at) >= DATE(seeker_profile_first_completed_at)
LEFT JOIN
    {{ ref('base__dbt_transformations__dim_seekers_participations') }} AS affiliation
    ON gap_fill_created_members.user_id = affiliation.user_id
LEFT JOIN
    {{ ref('int__marketplace__ambassadors_history') }} AS published_ambassadors
    ON gap_fill_created_members.user_id = affiliation.user_id
    AND DATE(gap_fill_created_members.seeker_profile_created_at) = DATE(dbt_valid_from)
