{{ config(materialized='table') }}

WITH snapshot_preped AS (
    SELECT
        user_id,
        user_situation,
        dbt_valid_from
    FROM
        {{ ref('base__dbt_transformations__snapshot_users_ambivalence') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY dbt_valid_from, user_id ORDER BY dbt_valid_from DESC) = 1
),

history AS (
    SELECT
        seeker_id,
        user_id,
        DATE(seeker_profile_created_at) AS seeker_profile_created_at,
        {{ member_primary_type(
            'user_is_high_school_teacher',
            'user_is_france_travail_job_seeker',
            'user_is_oriane_ambassador',
            'user_is_affiliated_to_any_vocation_program',
            'snapshot_preped.user_situation',
            'user_created_at'
        ) }} AS member_primary_type,
        snapshot_preped.user_situation,
        ambassador_company_name,
        company_sector_name,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        CASE
            WHEN DATE(dbt_valid_from) > DATE(seeker_profile_created_at) THEN DATE(seeker_profile_created_at)
            ELSE DATE(dbt_valid_from)
        END AS dbt_valid_from
    FROM
        {{ ref('int__marketplace__members') }}
    LEFT JOIN
            snapshot_preped
            USING(user_id)
    GROUP BY ALL
),

history_and_current_unioned AS (
    SELECT * FROM history
    UNION ALL
    SELECT
        seeker_id,
        user_id,
        seeker_profile_created_at,
        member_primary_type,
        user_situation,
        ambassador_company_name,
        company_sector_name,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        CURRENT_DATE() AS dbt_valid_from
    FROM history QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY dbt_valid_from DESC) = 1
)

SELECT
    *,
    dbt_valid_from = seeker_profile_created_at AS member_is_created
FROM
    history_and_current_unioned
