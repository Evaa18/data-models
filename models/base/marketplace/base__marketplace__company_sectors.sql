{{ config(materialized='view') }}

SELECT
    _id AS company_sector_id,
    created_at AS company_sector_created_at,
    updated_at AS company_sector_updated_at,
    name AS company_sector_name,
    normalized_name AS company_sector_normalized_name,
    linkedin_code AS company_sector_linkedin_code,
    COALESCE(hidden_from_search, FALSE) AS company_sector_is_hidden_from_search
FROM
    {{ source('marketplace', 'company_sectors') }}
