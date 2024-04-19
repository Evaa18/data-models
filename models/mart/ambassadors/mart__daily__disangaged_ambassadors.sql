{{ config(materialized='table') }}

SELECT
    DATE(dbt_valid_from) AS measured_at,
    ambassador_classification,
    ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    CASE
        WHEN ambassador_is_iced_up THEN 'iced_up_ambassadors'
        WHEN ambassador_is_soft_deleted THEN 'soft_deleted_ambassadors'
        WHEN ambassador_is_restricted THEN 'restricted_ambassadors'
        WHEN ambassador_is_invalidated THEN 'invalidated_ambassadors'
        ELSE 'unpublished_after_publication'
    END AS ambassador_disengagement_classification,
    COUNT(DISTINCT ambassador_id) AS disengaged_ambassadors
FROM
    {{ ref('int__marketplace__ambassadors_history_filled') }}
WHERE ambassador_is_disengaged
GROUP BY ALL
