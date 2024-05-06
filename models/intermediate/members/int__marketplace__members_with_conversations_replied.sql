{{ config(materialized='table') }}

SELECT
    DATE(conversation_denormalized_ambassador_first_response_at) AS conversation_replied_at,
    seekers.ambassador_company_name,
    seekers.company_sector_name,
    seekers.address_country,
    seekers.address_administrative_area_level_1_region_fr,
    seekers.address_administrative_area_level_2_department_fr,
    seekers.address_city_fr,
    seekers.address_postal_code,
    seekers.member_primary_type,
    {{ member_secondary_type(
        'seekers.member_primary_type',
        'seekers.user_situation',
        'ambassador_is_published'
    ) }} AS member_secondary_type,
    COUNT(DISTINCT conversations.seeker_id) AS seekers_replied_to,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_replied
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
LEFT JOIN
    {{ ref('int__marketplace__members') }} AS seekers
    USING(seeker_id)
LEFT JOIN
    {{ ref('int__marketplace__ambassadors_history_filled') }} AS history_filled
    ON DATE(conversation_initiated_at) = DATE(dbt_valid_from)
    AND seekers.user_id = history_filled.user_id
GROUP BY ALL
