{{ config(materialized='view') }}

SELECT
    date AS targeted_at,
    CASE
        WHEN primary_audience = 'affiliated_member' THEN 'affiliated_to_vocation_program'
        ELSE primary_audience
    END AS member_primary_type,
    CASE
        WHEN secondary_audience_ = 'ambassador_member' THEN 'member_also_published_as_ambassador'
        ELSE secondary_audience_
    END AS member_secondary_type,
    SUM(objective_value) AS target_value__created_members
FROM
    {{ source('google-sheets', 'target_created_members') }}
GROUP BY ALL
