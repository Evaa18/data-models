{{ config(materialized='table') }}

WITH history as (
SELECT
    int__marketplace__ambassadors.ambassador_id,
    snapshot.ambassador_company_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_administrative_area_level_3_fr,
    ambassador_is_published AS ambassador_is_published,
    ambassador_is_visible AS ambassador_is_visible,
    ambassador_is_available AS ambassador_is_available,
    dbt_valid_from
FROM
    {{ ref('int__marketplace__ambassadors') }}
LEFT JOIN
    {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }} AS snapshot
    USING(ambassador_id)
GROUP BY ALL
)

SELECT * FROM history
UNION ALL
SELECT 
    ambassador_id,
    ambassador_company_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_administrative_area_level_3_fr,
    ambassador_is_published,
    ambassador_is_visible,
    ambassador_is_available,
    CURRENT_TIMESTAMP() as dbt_valid_from
FROM history QUALIFY ROW_NUMBER() OVER (PARTITION BY ambassador_id ORDER BY dbt_valid_from DESC) = 1