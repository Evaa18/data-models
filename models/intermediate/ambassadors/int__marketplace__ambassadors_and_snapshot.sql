{{ config(materialized='table') }}

WITH joined_ambassadors_and_snapshot AS (
    SELECT
        snapshot.ambassador_id,
        snapshot.company_id,
        snapshot.ambassador_company_name,
        snapshot.ambassador_type,
        snapshot.ambassador_status,
        snapshot.ambassador_is_visible,
        snapshot.ambassador_is_available,
        snapshot.ambassador_is_hibernated,
        snapshot.ambassador_is_published,
        snapshot.ambassador_is_iced_up,
        snapshot.ambassador_is_soft_deleted,
        snapshot.ambassador_max_appointments_per_month,
        snapshot.dbt_valid_from,
        ambassadors.ambassador_job_title,
        ambassadors.address_country,
        ambassadors.address_administrative_area_level_1_region_fr,
        ambassadors.address_administrative_area_level_2_department_fr,
        ambassadors.address_administrative_area_level_3_fr
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }} AS snapshot
    LEFT JOIN
        {{ ref('int__marketplace__ambassadors') }} AS ambassadors
        USING(ambassador_id)
)

SELECT
    DATE(dbt_valid_from) AS dbt_valid_from,
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
    ) AS ambassadors_published_total
FROM
    joined_ambassadors_and_snapshot
GROUP BY ALL
