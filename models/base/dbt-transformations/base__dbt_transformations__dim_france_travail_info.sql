{{ config(materialized='view') }}

SELECT
    marketplace_user_id AS user_id,
    is_france_travail_job_seeker AS user_is_france_travail_job_seeker
FROM
    {{ source('dbt-transformations', 'dim_france_travail_info') }}
