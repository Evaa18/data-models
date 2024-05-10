{{ config(materialized='table') }}

SELECT
    appointment_or_claim_id,
    ambassador_id,
    seeker_id,
    conversation_id,
    appointment_or_claim_created_on_platform_at,
    appointment_or_claim_updated_at,
    appointment_start_at,
    appointment_unbooked_at,
    appointment_last_invalidated_at,
    appointment_or_claim,
    appointment_type,
    appointment_time_zone,
    appointment_address,
    appointment_meeting_place,
    appointment_coordinates,
    appointment_or_claim_general_status,
    appointment_or_claim_seeker_feedback_type,
    appointment_or_claim_ambassador_feedback_type,
    appointment_feedback_from_ambassador,
    appointment_feedback_from_seeker,
    appointment_is_invalidated,
    appointment_last_invalidated_reason,
    {{ appointment_is_nuida("appointment_is_invalidated", "appointment_or_claim_seeker_feedback_type", "appointment_or_claim_ambassador_feedback_type") }} AS appointment_or_claim_is_nuida
FROM
    {{ ref('int__marketplace__appointments_and_claims') }}
