{{ config(materialized='table') }}

SELECT
    DATE(ambassador_first_published_at) AS ambassador_first_published_at,
    ambassador_classification,
    ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    COUNT(DISTINCT ambassador_id) AS new_ambassadors_first_published
FROM
    {{ ref('int__marketplace__ambassadors') }}
GROUP BY ALL
