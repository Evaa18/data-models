{{ config(materialized='table') }}

WITH ambassadors_filled AS (
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
        COUNT(DISTINCT
            IF(
                ambassador_is_published,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_published,
        COUNT(DISTINCT
            IF(
                ambassador_is_unpublished
                AND NOT ambassador_is_iced_up
                AND NOT ambassador_is_restricted
                AND NOT ambassador_is_invalidated,
                ambassador_id,
                NULL
            )
        ) AS ambassador_unpublished,
        COUNT(DISTINCT
            IF(
                ambassador_is_published
                AND NOT ambassador_is_iced_up
                AND NOT ambassador_is_restricted
                AND NOT ambassador_is_invalidated,
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
        COUNT(DISTINCT
            IF(
                NOT ambassador_is_available,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_unavailable,
        COUNT(DISTINCT
            IF(
                ambassador_is_disengaged,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_disengaged,
        COUNT(DISTINCT
            IF(
                ambassador_is_iced_up,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_iced_up,
        COUNT(DISTINCT
            IF(
                ambassador_is_soft_deleted,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_soft_deleted,
        COUNT(DISTINCT
            IF(
                ambassador_is_restricted,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_restricted,
        COUNT(DISTINCT
            IF(
                ambassador_is_invalidated,
                ambassador_id,
                NULL
            )
        ) AS ambassadors_invalidated
    FROM
        {{ ref('int__marketplace__ambassadors_history_filled') }}
    GROUP BY ALL
),

conversations AS (
    SELECT
        conversation_initiated_at,
        ambassador_classification,
        ambassador_company_name,
        company_sector_name,
        ambassador_job_title,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        SUM(conversations_received) AS conversations_received,
        SUM(ambassadors_contacted) AS ambassadors_contacted
    FROM
        {{ ref('int__marketplace__contacted_ambassadors') }}
    GROUP BY ALL
),

new_published_ambassadors AS (
    SELECT
        ambassador_first_published_at,
        ambassador_classification,
        ambassador_company_name,
        company_sector_name,
        ambassador_job_title,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        SUM(new_ambassadors_published) AS new_ambassadors_published
    FROM
        {{ ref('int__marketplace__new_ambassadors_published') }}
    GROUP BY ALL
),

new_disengaged_ambassadors AS (
    SELECT
        DATE(dbt_valid_from) AS ambassador_first_disengaged_at,
        ambassador_classification,
        ambassador_company_name,
        company_sector_name,
        ambassador_job_title,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        new_ambassadors_first_disengaged_reason,
        COUNT(DISTINCT
            IF(
                new_ambassadors_is_unpublished,
                ambassador_id,
                NULL
            )
        ) AS new_ambassadors_unpublished,
        COUNT(DISTINCT
            IF(
                new_ambassadors_is_iced_up,
                ambassador_id,
                NULL
            )
        ) AS new_ambassadors_iced_up,
        COUNT(DISTINCT
            IF(
                new_ambassadors_is_soft_deleted,
                ambassador_id,
                NULL
            )
        ) AS new_ambassadors_soft_deleted,
        COUNT(DISTINCT
            IF(
                new_ambassadors_is_restricted,
                ambassador_id,
                NULL
            )
        ) AS new_ambassadors_restricted,
        COUNT(DISTINCT
            IF(
                new_ambassadors_is_invalidated,
                ambassador_id,
                NULL
            )
        ) AS new_ambassadors_invalidated,
        COUNT(DISTINCT
            IF(
                new_ambassadors_is_disengaged,
                ambassador_id,
                NULL
            )
        ) AS new_ambassadors_disengaged
    FROM
        {{ ref('int__marketplace__new_ambassadors_disengaged') }}
    GROUP BY ALL
),

target AS (
    SELECT
        targeted_at,
        ambassador_classification,
        MIN(target_value__published_ambassadors) AS target_value__published_ambassadors
    FROM
        {{ ref('base__google_sheets__target_published_ambassadors') }}
    GROUP BY ALL
)

SELECT
    COALESCE(ambassadors_filled.measured_at, conversations.conversation_initiated_at, new_published_ambassadors.ambassador_first_published_at, new_disengaged_ambassadors.ambassador_first_disengaged_at, target.targeted_at) AS measured_at,
    COALESCE(ambassadors_filled.ambassador_classification, conversations.ambassador_classification, new_published_ambassadors.ambassador_classification, new_disengaged_ambassadors.ambassador_classification, target.ambassador_classification) AS ambassador_classification,
    COALESCE(ambassadors_filled.ambassador_company_name, conversations.ambassador_company_name, new_published_ambassadors.ambassador_company_name, new_disengaged_ambassadors.ambassador_company_name) AS ambassador_company_name,
    COALESCE(ambassadors_filled.company_sector_name, conversations.company_sector_name, new_published_ambassadors.company_sector_name, new_disengaged_ambassadors.company_sector_name) AS company_sector_name,
    COALESCE(ambassadors_filled.ambassador_job_title, conversations.ambassador_job_title, new_published_ambassadors.ambassador_job_title, new_disengaged_ambassadors.ambassador_job_title) AS ambassador_job_title,
    COALESCE(ambassadors_filled.address_country, conversations.address_country, new_published_ambassadors.address_country, new_disengaged_ambassadors.address_country) AS address_country,
    COALESCE(ambassadors_filled.address_administrative_area_level_1_region_fr, conversations.address_administrative_area_level_1_region_fr, new_published_ambassadors.address_administrative_area_level_1_region_fr, new_disengaged_ambassadors.address_administrative_area_level_1_region_fr) AS address_administrative_area_level_1_region_fr,
    COALESCE(ambassadors_filled.address_administrative_area_level_2_department_fr, conversations.address_administrative_area_level_2_department_fr, new_published_ambassadors.address_administrative_area_level_2_department_fr, new_disengaged_ambassadors.address_administrative_area_level_2_department_fr) AS address_administrative_area_level_2_department_fr,
    COALESCE(ambassadors_filled.address_city_fr, conversations.address_city_fr, new_published_ambassadors.address_city_fr, new_disengaged_ambassadors.address_city_fr) AS address_city_fr,
    COALESCE(ambassadors_filled.address_postal_code, conversations.address_postal_code, new_published_ambassadors.address_postal_code, new_disengaged_ambassadors.address_postal_code) AS address_postal_code,
    new_ambassadors_first_disengaged_reason,
    ambassadors_published,
    ambassador_unpublished,
    ambassadors_visible,
    ambassadors_available,
    ambassadors_unavailable,
    ambassadors_disengaged,
    ambassadors_iced_up,
    ambassadors_soft_deleted,
    ambassadors_restricted,
    ambassadors_invalidated,
    conversations_received,
    ambassadors_contacted,
    new_ambassadors_published,
    new_ambassadors_unpublished,
    new_ambassadors_iced_up,
    new_ambassadors_soft_deleted,
    new_ambassadors_restricted,
    new_ambassadors_invalidated,
    new_ambassadors_disengaged,
    target_value__published_ambassadors
FROM
    ambassadors_filled
FULL OUTER JOIN
    conversations
    ON DATE(ambassadors_filled.measured_at) = conversations.conversation_initiated_at
    AND ambassadors_filled.ambassador_company_name = conversations.ambassador_company_name
    AND ambassadors_filled.company_sector_name = conversations.company_sector_name
    AND ambassadors_filled.ambassador_job_title = conversations.ambassador_job_title
    AND ambassadors_filled.address_country = conversations.address_country
    AND ambassadors_filled.address_administrative_area_level_1_region_fr = conversations.address_administrative_area_level_1_region_fr
    AND ambassadors_filled.address_administrative_area_level_2_department_fr = conversations.address_administrative_area_level_2_department_fr
    AND ambassadors_filled.address_city_fr = conversations.address_city_fr
    AND ambassadors_filled.address_postal_code = conversations.address_postal_code
    AND ambassadors_filled.ambassador_classification = conversations.ambassador_classification
FULL OUTER JOIN
    new_published_ambassadors
    ON DATE(ambassadors_filled.measured_at) = DATE(new_published_ambassadors.ambassador_first_published_at)
    AND ambassadors_filled.ambassador_company_name = new_published_ambassadors.ambassador_company_name
    AND ambassadors_filled.company_sector_name = new_published_ambassadors.company_sector_name
    AND ambassadors_filled.ambassador_job_title = new_published_ambassadors.ambassador_job_title
    AND ambassadors_filled.address_country = new_published_ambassadors.address_country
    AND ambassadors_filled.address_administrative_area_level_1_region_fr = new_published_ambassadors.address_administrative_area_level_1_region_fr
    AND ambassadors_filled.address_administrative_area_level_2_department_fr = new_published_ambassadors.address_administrative_area_level_2_department_fr
    AND ambassadors_filled.address_city_fr = new_published_ambassadors.address_city_fr
    AND ambassadors_filled.address_postal_code = new_published_ambassadors.address_postal_code
    AND ambassadors_filled.ambassador_classification = new_published_ambassadors.ambassador_classification
FULL OUTER JOIN
    new_disengaged_ambassadors
    ON DATE(ambassadors_filled.measured_at) = new_disengaged_ambassadors.ambassador_first_disengaged_at
    AND ambassadors_filled.ambassador_company_name = new_disengaged_ambassadors.ambassador_company_name
    AND ambassadors_filled.company_sector_name = new_disengaged_ambassadors.company_sector_name
    AND ambassadors_filled.ambassador_job_title = new_disengaged_ambassadors.ambassador_job_title
    AND ambassadors_filled.address_country = new_disengaged_ambassadors.address_country
    AND ambassadors_filled.address_administrative_area_level_1_region_fr = new_disengaged_ambassadors.address_administrative_area_level_1_region_fr
    AND ambassadors_filled.address_administrative_area_level_2_department_fr = new_disengaged_ambassadors.address_administrative_area_level_2_department_fr
    AND ambassadors_filled.address_city_fr = new_disengaged_ambassadors.address_city_fr
    AND ambassadors_filled.address_postal_code = new_disengaged_ambassadors.address_postal_code
    AND ambassadors_filled.ambassador_classification = new_disengaged_ambassadors.ambassador_classification
FULL OUTER JOIN
    target
    ON DATE(ambassadors_filled.measured_at) = target.targeted_at
    AND ambassadors_filled.ambassador_classification = target.ambassador_classification
