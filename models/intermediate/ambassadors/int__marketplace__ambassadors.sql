{{ config(materialized='table') }}

SELECT
    ambassadors.ambassador_id,
    ambassadors.company_id,
    address.address_id,
    company_sectors.company_sector_id,
    users.user_created_at,
    ambassador_company_name,
    ambassador_job_title,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_administrative_area_level_3_fr
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
