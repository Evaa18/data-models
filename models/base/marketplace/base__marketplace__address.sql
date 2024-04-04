{{ config(materialized='view') }}

SELECT
    _id AS address_id,
    google_place_id AS google_place_id,
    created_at AS address_create_at,
    completed_with_google_places_at AS address_completed_with_google_places_at,
    formatted_address.fr as address_formatted_fr,
    continent.fr[safe_offset(0)].value AS address_continent,
    country.fr[safe_offset(0)].value AS address_country,
    administrative_area_level_1.fr[safe_offset(0)].value AS address_administrative_area_level_1_region_fr,
    administrative_area_level_2.fr[safe_offset(0)].value AS address_administrative_area_level_2_department_fr,
    administrative_area_level_3.fr[safe_offset(0)].value AS address_administrative_area_level_3_fr,
    locality.fr[safe_offset(0)].value AS address_city_fr,
    sublocality_level_2.fr[safe_offset(0)].value AS address_sublocality_level_2_fr,
    colloquial_area.fr[safe_offset(0)].value AS address_colloquial_area_fr,
    postal_town.fr AS address_postal_town_fr,
    postal_code AS address_postal_code,
    political.fr AS address_political_fr,
FROM
    {{ source('marketplace', 'ambivalent_address_datasets') }}
