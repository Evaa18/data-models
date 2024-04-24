{{ config(materialized='table') }}

WITH snapshot_preped AS (
    SELECT
        ambassador_id,
        ambassador_company_name,
        dbt_valid_from
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY dbt_valid_from, ambassador_id ORDER BY dbt_valid_from DESC) = 1
),

new_iced_up_ambassadors AS (
    SELECT
        ambassador_id,
        MIN(dbt_valid_from) AS ambassador_first_iced_up_at
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    WHERE
        ambassador_is_iced_up
    GROUP BY ALL
),

new_soft_deleted_ambassadors AS (
    SELECT
        ambassador_id,
        MIN(dbt_valid_from) AS ambassador_first_soft_deleted_at
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    WHERE
        ambassador_is_soft_deleted
    GROUP BY ALL
),

new_restricted_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_last_restricted_at) AS ambassador_last_restricted_at
    FROM
        {{ ref('base__marketplace__ambassadors') }}
    WHERE
        ambassador_last_restricted_at IS NOT NULL
),

new_invalidated_ambassadors AS (
    SELECT
        ambassador_id,
        DATE(ambassador_last_invalidated_at) AS ambassador_last_invalidated_at
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    WHERE
        ambassador_last_invalidated_at IS NOT NULL
),

new_unpublished_ambassadors AS (
    SELECT
        ambassador_id,
        MIN(ambassador_last_unpublished_at) AS ambassador_last_unpublished_at
    FROM
        {{ ref('base__dbt_transformations__snapshot_ambassadors_status') }}
    WHERE
        NOT ambassador_is_iced_up
        AND (ambassador_last_restricted_at > ambassador_last_unpublished_at OR ambassador_last_restricted_at IS NULL)
        AND (ambassador_last_invalidated_at > ambassador_last_unpublished_at OR ambassador_last_invalidated_at IS NULL)
    GROUP BY ALL
),

joins AS (
SELECT
    ambassadors.ambassador_id,
    ambassador_classification,
    snapshot_preped.ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    dbt_valid_from,
    new_unpublished_ambassadors.ambassador_id IS NOT NULL AS new_ambassadors_is_unpublished,
    new_iced_up_ambassadors.ambassador_id IS NOT NULL AS new_ambassadors_is_iced_up,
    new_soft_deleted_ambassadors.ambassador_id IS NOT NULL AS new_ambassadors_is_soft_deleted,
    new_restricted_ambassadors.ambassador_id IS NOT NULL AS new_ambassadors_is_restricted,
    new_invalidated_ambassadors.ambassador_id IS NOT NULL AS new_ambassadors_is_invalidated
FROM
    {{ ref('int__marketplace__ambassadors') }} AS ambassadors
LEFT JOIN
    snapshot_preped
    USING(ambassador_id)
LEFT JOIN
    new_iced_up_ambassadors
    ON ambassadors.ambassador_id = new_iced_up_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) = DATE(ambassador_first_iced_up_at)
LEFT JOIN
    new_soft_deleted_ambassadors
    ON ambassadors.ambassador_id = new_soft_deleted_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) = DATE(ambassador_first_soft_deleted_at)
LEFT JOIN
    new_restricted_ambassadors
    ON ambassadors.ambassador_id = new_restricted_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) = DATE(ambassador_last_restricted_at)
LEFT JOIN
    new_invalidated_ambassadors
    ON ambassadors.ambassador_id = new_invalidated_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) = DATE(ambassador_last_invalidated_at)
LEFT JOIN
    new_unpublished_ambassadors
    ON ambassadors.ambassador_id = new_unpublished_ambassadors.ambassador_id
    AND DATE(dbt_valid_from) = DATE(ambassador_last_unpublished_at)
GROUP BY ALL
),

new_disengaged_ambassadors AS (
    SELECT
        ambassador_id,
        COALESCE(new_ambassadors_is_unpublished, new_ambassadors_is_iced_up, new_ambassadors_is_soft_deleted, new_ambassadors_is_restricted, new_ambassadors_is_invalidated) AS new_ambassadors_is_disengaged,
        CASE
            WHEN new_ambassadors_is_iced_up IS NOT NULL THEN 'new_ambassadors_is_iced_up'
            WHEN new_ambassadors_is_soft_deleted IS NOT NULL THEN 'new_ambassadors_is_soft_deleted'
            WHEN new_ambassadors_is_restricted IS NOT NULL THEN 'new_ambassadors_is_restricted'
            WHEN new_ambassadors_is_invalidated IS NOT NULL THEN 'new_ambassadors_is_invalidated'
            WHEN new_ambassadors_is_unpublished IS NOT NULL THEN 'new_ambassadors_is_unpublished'
        END AS new_ambassadors_first_disengaged_reason,
        MIN(dbt_valid_from) AS ambassador_first_disengaged_at
    FROM
        joins
    WHERE
        COALESCE(new_ambassadors_is_unpublished, new_ambassadors_is_iced_up, new_ambassadors_is_soft_deleted, new_ambassadors_is_restricted, new_ambassadors_is_invalidated) IS NOT NULL
    GROUP BY ALL
)

SELECT
    joins.ambassador_id,
    ambassador_classification,
    ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    dbt_valid_from,
    new_ambassadors_is_unpublished,
    new_ambassadors_is_iced_up,
    new_ambassadors_is_soft_deleted,
    new_ambassadors_is_restricted,
    new_ambassadors_is_invalidated,
    new_ambassadors_is_disengaged,
    new_ambassadors_first_disengaged_reason
FROM
    joins
LEFT JOIN
    new_disengaged_ambassadors
    ON  joins.ambassador_id = new_disengaged_ambassadors.ambassador_id
    AND joins.dbt_valid_from = new_disengaged_ambassadors.ambassador_first_disengaged_at
