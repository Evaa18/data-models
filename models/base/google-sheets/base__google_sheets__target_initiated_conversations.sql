{{ config(materialized='view') }}

SELECT
    date AS targeted_at,
    objective_value AS target_value__initiated_conversations
FROM
    {{ source('google-sheets', 'target_initiated_conversations') }}
