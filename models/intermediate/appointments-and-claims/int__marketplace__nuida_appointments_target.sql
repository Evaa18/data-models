{{ config(materialized='table') }}

SELECT
    targeted_at,
    target_value__nuida_appointments
FROM
    {{ ref('base__google_sheets__target_nuida_appointments') }}
