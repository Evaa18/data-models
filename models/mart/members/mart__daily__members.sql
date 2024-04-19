{{ config(materialized='table') }}

SELECT
    DATE(measured_at) AS measured_at,
    member_type,
    ambassador_company_name,
    company_sector_name,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code,
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
