{{ config(materialized='table') }}

SELECT
    DATE(conversation_denormalized_ambassador_first_response_at) AS conversation_replied_at,
    ambassador_company_name,
    company_sector_name,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    member_primary_type,
    COUNT(DISTINCT conversations.seeker_id) AS seekers_replied_to,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_replied
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
LEFT JOIN
    {{ ref('int__marketplace__members') }} AS seekers
    USING(seeker_id)
GROUP BY ALL
