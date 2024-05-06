{{ config(materialized='table') }}

WITH affiliation_members AS (
    SELECT
        seeker_id,
        users.user_id,
        seeker_profile_created_at,
        user_is_high_school_teacher,
        users.user_situation,
        user_is_oriane_ambassador,
        user_is_france_travail_job_seeker,
        user_created_at,
        user_is_currently_involved_in_a_fdr OR user_is_all_time_involved_in_a_fdr AS user_is_affiliated_to_any_vocation_program,
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
    LEFT JOIN
        {{ ref('base__dbt_transformations__dim_seekers_participations') }} AS affiliation
        ON users.user_id = affiliation.user_id
    LEFT JOIN
        {{ ref('base__dbt_transformations__dim_france_travail_info') }} AS france_travail
        ON users.user_id = france_travail.user_id
)

SELECT
    seeker_id,
    user_id,
    seeker_profile_created_at,
    user_situation,
    {{ member_primary_type(
        'user_is_high_school_teacher',
        'user_is_france_travail_job_seeker',
        'user_is_oriane_ambassador',
        'user_is_affiliated_to_any_vocation_program',
        'user_situation',
        'user_created_at'
    ) }} AS member_primary_type,
    ambassador_company_name,
    company_sector_name,
    address_country,
    address_administrative_area_level_1_region_fr,
    address_administrative_area_level_2_department_fr,
    address_city_fr,
    address_postal_code
FROM
    affiliation_members
