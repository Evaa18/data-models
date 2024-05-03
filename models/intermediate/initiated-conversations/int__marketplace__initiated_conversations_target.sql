{{ config(materialized='table') }}

SELECT
    targeted_at,
    target_value__initiated_conversations
FROM
    {{ ref('base__google_sheets__target_initiated_conversations') }}
