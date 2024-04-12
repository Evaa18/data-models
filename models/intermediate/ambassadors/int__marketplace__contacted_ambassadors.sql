{{ config(materialized='table') }}

SELECT
    DATE(conversation_initiated_at) AS conversation_initiated_at,
    ambassador_company_name,
    company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    ambassador_classification,
    COUNT(DISTINCT conversations.ambassador_id) AS ambassadors_contacted,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_received
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
LEFT JOIN
    {{ ref('int__marketplace__ambassadors') }} AS ambassadors
    USING(ambassador_id)
GROUP BY ALL
