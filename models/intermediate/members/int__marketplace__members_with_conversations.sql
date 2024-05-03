{{ config(materialized='table') }}

SELECT
    DATE(conversation_initiated_at) AS conversation_initiated_at,
    seekers.ambassador_company_name,
    seekers.company_sector_name,
    seekers.address_country,
    seekers.address_administrative_area_level_1_region_fr,
    seekers.address_administrative_area_level_2_department_fr,
    seekers.address_city_fr,
    seekers.address_postal_code,
    seekers.member_primary_type,
    history_filled.member_secondary_type,
    COUNT(DISTINCT conversations.seeker_id) AS seekers_contacting,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_sent
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
LEFT JOIN
    {{ ref('int__marketplace__members') }} AS seekers
    USING(seeker_id)
LEFT JOIN
    {{ ref('int__marketplace__members_history_filled') }} AS history_filled
    ON DATE(conversation_initiated_at) = measured_at
    AND seekers.seeker_id = history_filled.seeker_id
GROUP BY ALL
