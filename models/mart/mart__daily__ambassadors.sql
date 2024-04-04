{{ config(materialized='table') }}

WITH calendar AS (
    SELECT
        *
    FROM
        UNNEST(
            GENERATE_DATE_ARRAY(
                '2016-06-01',
                CURRENT_DATE(),
                INTERVAL 1 DAY)
            ) AS measured_at
),

ambassadors AS (
    SELECT
        int__marketplace__ambassadors.ambassador_id,
        snapshot.ambassador_company_name,
        ambassador_job_title,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_administrative_area_level_3_fr,
        ambassador_is_published,
        ambassador_is_visible,
        ambassador_is_available,
        dbt_valid_from,
        dbt_valid_to
    FROM
        {{ ref('int__marketplace__ambassadors') }}
    LEFT JOIN
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }} AS snapshot
        USING(ambassador_id)
)

SELECT
    measured_at,
    ambassadors.ambassador_company_name,
    ambassadors.ambassador_job_title,
    ambassadors.address_country,
    ambassadors.address_administrative_area_level_1_region_fr,
    ambassadors.address_administrative_area_level_2_department_fr,
    ambassadors.address_administrative_area_level_3_fr,
    COUNT(DISTINCT
        IF(
            ambassador_is_published,
            ambassador_id,
            NULL
        )
    ) AS ambassadors_published_total,
    COUNT(DISTINCT
        IF(
            ambassador_is_visible,
            ambassador_id,
            NULL
        )
    ) AS ambassadors_visible_total,
    COUNT(DISTINCT
        IF(
            ambassador_is_available,
            ambassador_id,
            NULL
        )
    ) AS ambassadors_available_total,
FROM
    calendar
LEFT JOIN
    ambassadors
    ON (DATE(ambassadors.dbt_valid_from) <= calendar.measured_at AND DATE(dbt_valid_to) IS NULL)
    OR (DATE(ambassadors.dbt_valid_to) >= calendar.measured_at)
{{ dbt_utils.group_by(7) }}
