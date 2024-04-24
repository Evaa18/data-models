{{ config(materialized='table') }}

SELECT
    DATE(conversation_initiated_at) AS conversation_initiated_at,
    ambassador_company_name,
    company_sector_name,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    member_type,
    COUNT(DISTINCT conversations.seeker_id) AS seekers_contacting,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_received
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
LEFT JOIN
    {{ ref('int__marketplace__members') }} AS seekers
    USING(seeker_id)
GROUP BY ALL
