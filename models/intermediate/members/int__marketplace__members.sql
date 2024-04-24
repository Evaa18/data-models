{{ config(materialized='table') }}

SELECT
    seeker_id,
    user_id,
    seeker_profile_created_at,
    IF(
        user_is_high_school_teacher,
        'school_teacher',
        user_situation
    ) AS member_type,
    ambassador_company_name,
    company_sector_name.en AS company_sector_name,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code
FROM
    {{ ref('base__marketplace__seekers') }} AS seekers
INNER JOIN
    {{ ref('base__marketplace__users') }} AS users
    USING(user_id)
LEFT JOIN
    {{ ref('base__marketplace__ambassadors') }} AS ambassadors
    USING(user_id)
LEFT JOIN
    {{ ref('base__marketplace__company_sectors') }} AS company_sectors
    USING(company_sector_id)
LEFT JOIN
    {{ ref('base__marketplace__address') }} AS address
    ON users.desired_meeting_address_id = address.address_id
