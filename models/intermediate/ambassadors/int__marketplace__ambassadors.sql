{{ config(materialized='table') }}

SELECT
    ambassadors.ambassador_id,
    ambassadors.company_id,
    address.address_id,
    company_sectors.company_sector_id,
    users.user_created_at,
    ambassador_first_published_at,
    ambassador_company_name,
    company_sector_name.en AS company_sector_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    CASE
        WHEN {{ ambassador_is_industry_ambassador("ambassadors.company_id") }}
        THEN 'industry'
        WHEN {{ ambassador_is_premium("ambassador_type") }}
        THEN 'premium_except_industry'
        WHEN ambassador_type = 'Mentor' AND (user_situation = 'in_activity' OR users.account_created_at < {{ professional_members_release_date() }})
        THEN 'ambassadors_except_youth' --if nulls, add in 'ambassadors_except_youth' (user premium(company::employee) not in_activity)
        WHEN NOT user_situation = 'in_activity' AND users.account_created_at < {{ youth_ambassadors_release_date() }} --add that we only select the ones who have an user_created_at AFTER the realease date of ambivalence-v2
        THEN 'pre_ambivalence_member_now_youth_ambassador'
        WHEN NOT user_situation = 'in_activity' AND users.account_created_at > {{ youth_ambassadors_release_date() }} --add that we only select the ones who have an user_created_at AFTER the realease date of ambivalence-v2
        THEN 'youth_ambassador'
        ELSE 'unsure'
    END AS ambassador_classification
FROM
    {{ ref('base__marketplace__ambassadors') }} AS ambassadors
INNER JOIN
    {{ ref('base__marketplace__users') }} AS users
    USING(user_id)
LEFT JOIN
    {{ ref('base__marketplace__company_sectors') }} AS company_sectors
    USING(company_sector_id)
LEFT JOIN
    {{ ref('base__marketplace__address') }} AS address
    ON users.desired_meeting_address_id = address.address_id
