{{ config(materialized='table') }}

WITH gap_fill_created_members AS (
    SELECT
        *
    FROM
        GAP_FILL(
            (SELECT * FROM {{ ref('int__marketplace__members_history') }}),
            ts_column => 'seeker_profile_created_at',
            bucket_width => INTERVAL 1 DAY,
            partitioning_columns => ['seeker_id','member_type','ambassador_company_name','company_sector_name','address_country','address_administrative_area_level_1_region_fr','address_administrative_area_level_2_department_fr','address_city_fr', 'address_postal_code'],
            value_columns => [
                ('member_is_created','null')
            ]
        )
)

SELECT
    COALESCE(gap_fill_created_members.seeker_id, activation.seeker_id) AS seeker_id,
    COALESCE(gap_fill_created_members.seeker_profile_created_at, DATE(activation.member_activated_at)) AS measured_at,
    gap_fill_created_members.* EXCEPT(seeker_id, seeker_profile_created_at),
    activation.user_id IS NOT NULL AS member_is_activated
FROM
    gap_fill_created_members
FULL OUTER JOIN
    {{ ref('int__marketplace__members_activation') }} AS activation
    ON DATE(activation.member_activated_at) = DATE(gap_fill_created_members.seeker_profile_created_at)
    AND activation.seeker_id = gap_fill_created_members.seeker_id
