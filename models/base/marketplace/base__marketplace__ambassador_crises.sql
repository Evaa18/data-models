{{ config(materialized='view') }}

SELECT
    _id AS ambassador_crisis_id,
    professional_id AS ambassador_id,
    created_at AS ambassador_crisis_created_at,
    started_at AS ambassador_crisis_started_at,
    ended_at AS ambassador_crisis_ended_at,
    average_response_time_at_start_of_crisis AS ambassador_crisis_average_response_time_at_start_of_crisis,
    crisis_level_cd AS ambassador_crisis_level_cd
FROM
    {{ source('marketplace', 'professional_crises') }}
