{{ config(materialized='view') }}

SELECT
    _id AS appointment_id,
    professional_id AS ambassador_id,
    seeker_id,
    conversation_id,
    appointment_claim_id AS appointment_requested_by_seeker_id,
    created_at AS appointment_created_on_platform_at,
    updated_at AS appointment_updated_at,
    hermes_apt.from as time_of_appointment,
    hermes_apt.to as legacy_time_of_appointment_end,

FROM
    {{ source('marketplace', 'appointments') }}
