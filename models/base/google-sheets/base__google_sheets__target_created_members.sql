{{ config(materialized='view') }}

SELECT
    date AS targeted_at,
    audience AS target_audience,
    objective_value AS target_value__active_memners
FROM
    {{ source('google-sheets', 'target_members') }}
WHERE type = 'active'
