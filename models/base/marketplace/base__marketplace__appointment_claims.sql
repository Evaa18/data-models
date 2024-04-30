{{ config(materialized='view') }}

SELECT
    _id AS appointment_claim_id,
    professional_id AS ambassador_id,
    seeker_id,
    conversation_id,
    created_at AS appointment_claim_created_on_platform_at,
    updated_at AS appointment_claim_updated_at,
    resolved_at AS appointment_claim_resolved_at,
    messaging_appointment_claims.from AS appointment_start_at,
    messaging_appointment_claims.to AS appointment_end_at,
    {{ appointment_type('type_cd') }} AS appointment_type,
    CASE
        WHEN accepted IS NULL THEN 'pending'
        WHEN accepted = TRUE THEN 'accepted'
        WHEN accepted = FALSE THEN 'refused'
    END AS appointment_claim_status,
    address_dataset AS appointment_address,
    meeting_place AS appointment_meeting_place,
    coordinates AS appointment_coordinates,
    time_zone AS appointment_time_zone
FROM
    {{ source('marketplace', 'messaging_appointment_claims') }}
