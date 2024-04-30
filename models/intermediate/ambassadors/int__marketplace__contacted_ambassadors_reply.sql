{{ config(materialized='table') }}

SELECT
    DATE(conversation_denormalized_ambassador_first_response_at) AS conversation_replied_at,
    ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    ambassador_classification,
    COUNT(DISTINCT conversations.ambassador_id) AS ambassadors_replying,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_replied
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
LEFT JOIN
    {{ ref('int__marketplace__ambassadors') }} AS ambassadors
    USING(ambassador_id)
WHERE
    conversation_denormalized_ambassador_first_response_at IS NOT NULL
GROUP BY ALL
