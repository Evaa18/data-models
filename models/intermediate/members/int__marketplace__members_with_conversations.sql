{{ config(materialized='table') }}

WITH ambassador_members AS (
    SELECT
        members.user_id,
        DATE(members.dbt_valid_from) AS dbt_valid_from,
        IF(ambassador_is_published IS NULL, FALSE, ambassador_is_published) AS ambassador_is_published
    FROM
        {{ ref('int__marketplace__members_history') }} AS members
    LEFT JOIN
        {{ ref('int__marketplace__ambassadors_history_filled') }} AS ambassadors
        ON members.user_id = ambassadors.user_id
        AND DATE(members.dbt_valid_from) = DATE(ambassadors.dbt_valid_from)
)

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
    {{ member_secondary_type(
        'seekers.member_primary_type',
        'seekers.user_situation',
        'ambassador_is_published'
    ) }} AS member_secondary_type,
    COUNT(DISTINCT conversations.seeker_id) AS seekers_contacting,
    COUNT(DISTINCT conversations.conversation_id) AS conversations_sent
FROM
    {{ ref('base__marketplace__conversations') }} AS conversations
INNER JOIN
    {{ ref('int__marketplace__members_history') }} AS seekers
    USING(seeker_id)
LEFT JOIN
    ambassador_members
    ON seekers.user_id = ambassador_members.user_id
    AND DATE(seekers.dbt_valid_from) = DATE(ambassador_members.dbt_valid_from)
GROUP BY ALL
