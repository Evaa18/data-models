{{ config(materialized='table') }}

WITH snapshot_preped AS (
    SELECT
        ambassador_id,
        ambassador_company_name,
        ambassador_is_published,
        ambassador_is_visible,
        ambassador_is_available,
        ambassador_is_hibernated,
        ambassador_is_iced_up,
        ambassador_is_soft_deleted,
        dbt_valid_from
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY dbt_valid_from, ambassador_id ORDER BY dbt_valid_from DESC) = 1
),

history AS (
    SELECT
        int__marketplace__ambassadors.ambassador_id,
        user_id,
        ambassador_classification,
        snapshot_preped.ambassador_company_name,
        company_sector_name,
        ambassador_job_title,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        ambassador_is_published,
        ambassador_is_visible,
        ambassador_is_available,
        ambassador_is_hibernated,
        ambassador_is_iced_up,
        ambassador_is_soft_deleted,
        dbt_valid_from
    FROM
        {{ ref('int__marketplace__ambassadors') }}
    LEFT JOIN
        snapshot_preped
        USING(ambassador_id)
    GROUP BY ALL
)

SELECT * FROM history
UNION ALL
SELECT
    ambassador_id,
    user_id,
    ambassador_classification,
    ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    ambassador_is_published,
    ambassador_is_visible,
    ambassador_is_available,
    ambassador_is_hibernated,
    ambassador_is_iced_up,
    ambassador_is_soft_deleted,
    CURRENT_TIMESTAMP() AS dbt_valid_from
FROM history QUALIFY ROW_NUMBER() OVER (PARTITION BY ambassador_id ORDER BY dbt_valid_from DESC) = 1
