{{ config(materialized='view') }}

SELECT
    date AS targeted_at,
    objective_value AS target_value__nuida_appointments
FROM
    {{ source('google-sheets', 'target_nuida_appointments') }}
