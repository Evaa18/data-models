{{ config(materialized='table') }}

SELECT
    DATE(dbt_valid_from) as measured_at,
    ambassador_classification,
    ambassador_company_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_administrative_area_level_3_fr,
    COUNT(DISTINCT
        IF(
            ambassador_is_published,
            ambassador_id,
            NULL
        )
    ) AS ambassadors_published,
    COUNT(DISTINCT
        IF(
            ambassador_is_visible,
            ambassador_id,
            NULL
        )
    ) AS ambassadors_visible,
    COUNT(DISTINCT
        IF(
            ambassador_is_available,
            ambassador_id,
            NULL
        )
    ) AS ambassadors_available,
FROM
    {{ ref('int__marketplace__ambassadors_history_filled') }}
GROUP BY ALL
