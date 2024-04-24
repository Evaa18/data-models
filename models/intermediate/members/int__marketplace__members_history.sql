{{ config(materialized='table') }}


SELECT
    seeker_id,
    user_id,
    DATE(seeker_profile_created_at) AS seeker_profile_created_at,
    member_type,
    ambassador_company_name,
    company_sector_name,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
    TRUE AS member_is_created
FROM
    {{ ref('int__marketplace__members') }}
