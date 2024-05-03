{{ config(materialized='table') }}

WITH members_activated_and_created AS (
    SELECT
        DATE(measured_at) AS measured_at,
        member_primary_type,
        member_secondary_type,
        member_activation,
        member_affiliation,
        ambassador_company_name,
        company_sector_name,
        address_country,
        address_administrative_area_level_1_region_fr,
        address_administrative_area_level_2_department_fr,
        address_city_fr,
        address_postal_code,
        nuida_appointments,
        COUNT(DISTINCT
            IF(
                member_is_created,
                seeker_id,
                NULL
            )
        ) AS new_members_created,
        COUNT(DISTINCT
            IF(
                member_is_activated,
                seeker_id,
                NULL
            )
        ) AS new_members_activated
    FROM
        {{ ref('int__marketplace__members_history_filled') }}
    GROUP BY ALL
),

target AS (
    SELECT
        targeted_at,
        member_primary_type,
        member_secondary_type,
        MIN(target_value__created_members) AS target_value__created_members
    FROM
        {{ ref('base__google_sheets__target_created_members') }}
    GROUP BY ALL
)

SELECT
    COALESCE(measured_at, conversation_initiated_at, target.targeted_at) AS measured_at,
    COALESCE(members_activated_and_created.member_primary_type, conversations.member_primary_type, target.member_primary_type) AS member_primary_type,
    COALESCE(members_activated_and_created.member_secondary_type, target.member_secondary_type, target.member_secondary_type) AS member_secondary_type,
    member_activation,
    member_affiliation,
    COALESCE(members_activated_and_created.ambassador_company_name, conversations.ambassador_company_name) AS ambassador_company_name,
    COALESCE(members_activated_and_created.company_sector_name, conversations.company_sector_name) AS company_sector_name,
    COALESCE(members_activated_and_created.address_country, conversations.address_country) AS address_country,
    COALESCE(members_activated_and_created.address_administrative_area_level_1_region_fr, conversations.address_administrative_area_level_1_region_fr) AS address_administrative_area_level_1_region_fr,
    COALESCE(members_activated_and_created.address_administrative_area_level_2_department_fr, conversations.address_administrative_area_level_2_department_fr) AS address_administrative_area_level_2_department_fr,
    COALESCE(members_activated_and_created.address_city_fr, conversations.address_city_fr) AS address_city_fr,
    COALESCE(members_activated_and_created.address_postal_code, conversations.address_postal_code) AS address_postal_code,
    nuida_appointments,
    new_members_created,
    new_members_activated,
    seekers_contacting,
    conversations_sent,
    seekers_replied_to,
    conversations_replied,
    target_value__created_members
FROM
    members_activated_and_created
FULL OUTER JOIN
    {{ ref('int__marketplace__members_with_conversations') }} AS conversations
    ON members_activated_and_created.measured_at = conversations.conversation_initiated_at
    AND members_activated_and_created.member_primary_type = conversations.member_primary_type
    AND members_activated_and_created.ambassador_company_name = conversations.ambassador_company_name
    AND members_activated_and_created.company_sector_name = conversations.company_sector_name
    AND members_activated_and_created.address_country = conversations.address_country
    AND members_activated_and_created.address_administrative_area_level_1_region_fr = conversations.address_administrative_area_level_1_region_fr
    AND members_activated_and_created.address_administrative_area_level_2_department_fr = conversations.address_administrative_area_level_2_department_fr
    AND members_activated_and_created.address_city_fr = conversations.address_city_fr
    AND members_activated_and_created.address_postal_code = conversations.address_postal_code
FULL OUTER JOIN
    {{ ref('int__marketplace__members_with_conversations_replied') }} AS replies
    ON members_activated_and_created.measured_at = replies.conversation_replied_at
    AND members_activated_and_created.member_primary_type = replies.member_primary_type
    AND members_activated_and_created.ambassador_company_name = replies.ambassador_company_name
    AND members_activated_and_created.company_sector_name = replies.company_sector_name
    AND members_activated_and_created.address_country = replies.address_country
    AND members_activated_and_created.address_administrative_area_level_1_region_fr = replies.address_administrative_area_level_1_region_fr
    AND members_activated_and_created.address_administrative_area_level_2_department_fr = replies.address_administrative_area_level_2_department_fr
    AND members_activated_and_created.address_city_fr = replies.address_city_fr
    AND members_activated_and_created.address_postal_code = replies.address_postal_code
FULL OUTER JOIN
    target
    ON DATE(members_activated_and_created.measured_at) = target.targeted_at
    AND members_activated_and_created.member_primary_type = target.member_primary_type
    AND members_activated_and_created.member_secondary_type = target.member_secondary_type
