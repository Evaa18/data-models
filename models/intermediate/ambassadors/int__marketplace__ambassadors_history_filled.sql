{{ config(materialized='table') }}

WITH gap_fill_ambassadors AS (
    SELECT
        *
    FROM
        GAP_FILL(
            (SELECT * FROM {{ ref('int__marketplace__ambassadors_history') }}),
            ts_column => 'dbt_valid_from',
            bucket_width => INTERVAL 1 DAY,
            partitioning_columns => ['ambassador_id','ambassador_classification','ambassador_company_name','company_sector_name','ambassador_job_title','address_country','address_administrative_area_level_1_region_fr','address_administrative_area_level_2_department_fr','address_city_fr', 'address_postal_code'],
            value_columns => [
                ('ambassador_is_published','locf'),
                ('ambassador_is_visible','locf'),
                ('ambassador_is_available','locf'),
                ('ambassador_is_hibernated','locf'),
                ('ambassador_is_iced_up','locf'),
                ('ambassador_is_soft_deleted','locf')
            ]
        )
),

unpublished_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_first_published_at) AS ambassador_first_published_at
    FROM
        {{ ref('base__marketplace__ambassadors') }}
),

warm_up_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_warmup_started_at) AS ambassador_warmup_started_at,
        DATE(ambassador_warmup_ended_at) AS ambassador_warmup_ended_at
    FROM
        {{ ref('base__marketplace__ambassadors') }}
    WHERE
        ambassador_warmup_started_at IS NOT NULL
),

restricted_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_last_restricted_at) AS ambassador_last_restricted_at,
        DATE(ambassador_last_unrestricted_at) AS ambassador_last_unrestricted_at
    FROM
        {{ ref('base__marketplace__ambassadors') }}
    WHERE
        ambassador_last_restricted_at IS NOT NULL
),

invalidated_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_last_invalidated_at) AS ambassador_last_invalidated_at
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    WHERE
        ambassador_last_invalidated_at IS NOT NULL
),

red_crisis_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_crisis_started_at) AS ambassador_crisis_started_at,
        DATE(ambassador_crisis_ended_at) AS ambassador_crisis_ended_at
    FROM
        {{ ref('base__marketplace__ambassador_crisis') }}
    WHERE
        ambassador_crisis_level_cd = 'red'
        AND ambassador_crisis_started_at IS NOT NULL
)

SELECT
    gap_fill_ambassadors.*,
    warm_up_ambassadors.ambassador_id IS NOT NULL AS ambassador_is_in_warm_up,
    restricted_ambassadors.ambassador_id IS NOT NULL AS ambassador_is_restricted,
    invalidated_ambassadors.ambassador_id IS NOT NULL AS ambassador_is_invalidated,
    unpublished_ambassadors.ambassador_id IS NOT NULL AS ambassador_is_unpublished,
    red_crisis_ambassadors.ambassador_id IS NOT NULL AS ambassador_is_in_red_crisis,
    IF(
        ambassador_first_published_at < DATE(dbt_valid_from)
        OR ambassador_is_iced_up
        OR ambassador_is_soft_deleted
        OR restricted_ambassadors.ambassador_id IS NOT NULL
        OR invalidated_ambassadors.ambassador_id IS NOT NULL,
        TRUE,
        FALSE
    ) AS ambassador_is_disengaged
FROM
    gap_fill_ambassadors
LEFT JOIN
    unpublished_ambassadors
    ON unpublished_ambassadors.ambassador_id = gap_fill_ambassadors.ambassador_id
    AND (DATE(dbt_valid_from) >= ambassador_first_published_at OR ambassador_first_published_at IS NULL)
LEFT JOIN
    warm_up_ambassadors
    ON warm_up_ambassadors.ambassador_id = gap_fill_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) >= ambassador_warmup_started_at
    AND (DATE(dbt_valid_from) <= ambassador_warmup_ended_at OR ambassador_warmup_ended_at IS NULL)
LEFT JOIN
    restricted_ambassadors
    ON restricted_ambassadors.ambassador_id = gap_fill_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) >= ambassador_last_restricted_at
    AND (DATE(dbt_valid_from) <= ambassador_last_unrestricted_at OR ambassador_last_unrestricted_at IS NULL)
LEFT JOIN
    invalidated_ambassadors
    ON invalidated_ambassadors.ambassador_id = gap_fill_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) >= ambassador_last_invalidated_at
LEFT JOIN
    red_crisis_ambassadors
    ON red_crisis_ambassadors.ambassador_id = gap_fill_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) >= ambassador_crisis_started_at
    AND (DATE(dbt_valid_from) <= ambassador_crisis_ended_at OR ambassador_crisis_ended_at IS NULL)
