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
        member_primary_type,
        snapshot_preped.user_situation,
        ambassador_company_name,
        company_sector_name,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        TRUE AS member_is_created,
        dbt_valid_from
    FROM
        {{ ref('int__marketplace__members') }}
    LEFT JOIN
            snapshot_preped
            USING(user_id)
    GROUP BY ALL
)

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
    member_is_created,
    CURRENT_TIMESTAMP() AS dbt_valid_from
FROM history QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY dbt_valid_from DESC) = 1
