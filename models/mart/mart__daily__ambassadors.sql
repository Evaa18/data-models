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
            ambassador_is_unpublished
            AND NOT ambassador_is_iced_up
            AND NOT ambassador_is_restricted
            AND NOT ambassador_is_invalidated,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassador_unpublished,
    COUNT(DISTINCT
        IF(
            ambassador_is_published
            AND NOT ambassador_is_iced_up
            AND NOT ambassador_is_restricted
            AND NOT ambassador_is_invalidated,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassadors_visible,
    COUNT(DISTINCT
        IF(
            NOT ambassador_is_available
            AND NOT ambassador_is_iced_up
            AND NOT ambassador_is_restricted
            AND NOT ambassador_is_invalidated,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassadors_available,
    COUNT(DISTINCT
        IF(
            ambassador_is_available
            AND NOT ambassador_is_iced_up
            AND NOT ambassador_is_restricted
            AND NOT ambassador_is_invalidated,
            ambassadors_filled.ambassador_id,
            NULL
        )
    ) AS ambassadors_unavailable,
    SUM(ambassadors_contacted) AS ambassadors_contacted,
    SUM(conversations_received) AS conversations_received
FROM
    {{ ref('int__marketplace__ambassadors_history_filled') }} AS ambassadors_filled
LEFT JOIN
    {{ ref('int__marketplace__contacted_ambassadors') }} AS conversations
    ON DATE(ambassadors_filled.dbt_valid_from) = conversations.conversation_initiated_at
    AND ambassadors_filled.ambassador_company_name = conversations.ambassador_company_name
    AND ambassadors_filled.company_sector_name = conversations.company_sector_name
    AND ambassadors_filled.ambassador_job_title = conversations.ambassador_job_title
    AND ambassadors_filled.address_country = conversations.address_country
    AND ambassadors_filled.address_administrative_area_level_1_region_fr = conversations.address_administrative_area_level_1_region_fr
    AND ambassadors_filled.address_administrative_area_level_2_department_fr = conversations.address_administrative_area_level_2_department_fr
    AND ambassadors_filled.address_city_fr = conversations.address_city_fr
    AND ambassadors_filled.address_postal_code = conversations.address_postal_code
    AND ambassadors_filled.ambassador_classification = conversations.ambassador_classification
GROUP BY ALL
