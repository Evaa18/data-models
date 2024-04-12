{{ config(materialized='table') }}

SELECT
    DATE(dbt_valid_from) AS measured_at,
    ambassadors_filled.ambassador_classification,
    ambassadors_filled.ambassador_company_name,
    ambassadors_filled.company_sector_name,
    ambassadors_filled.ambassador_job_title,
    ambassadors_filled.address_country,
    ambassadors_filled.address_administrative_area_level_1_region_fr,
    ambassadors_filled.address_administrative_area_level_2_department_fr,
    ambassadors_filled.address_city_fr,
    ambassadors_filled.address_postal_code,
    COUNT(DISTINCT
        IF(
            ambassador_is_published,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassadors_published,
    COUNT(DISTINCT
        IF(
            ambassador_is_visible,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassadors_visible,
    COUNT(DISTINCT
        IF(
            ambassador_is_available,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassadors_available,
FROM
    {{ ref('int__marketplace__ambassadors_history_filled') }} AS ambassadors_filled
GROUP BY ALL
