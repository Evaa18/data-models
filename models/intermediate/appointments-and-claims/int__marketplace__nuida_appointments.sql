{{ config(materialized='table') }}

SELECT
    appointment_or_claim_id,
    ambassador_id,
    seeker_id,
    conversation_id,
    appointment_or_claim_created_on_platform_at,
    appointment_or_claim_updated_at,
    appointment_or_claim_start_at,
    appointment_or_claim_unbooked_at,
    appointment_or_claim_last_invalidated_at,
    appointment_or_claim,
    appointment_or_claim_type,
    appointment_or_claim_time_zone,
    appointment_or_claim_address,
    appointment_or_claim_meeting_place,
    appointment_or_claim_coordinates,
    appointment_or_claim_general_status,
    appointment_or_claim_seeker_feedback_type,
    appointment_or_claim_ambassador_feedback_type,
    appointment_or_claim_feedback_from_ambassador,
    appointment_or_claim_feedback_from_seeker,
    appointment_or_claim_is_invalidated,
    appointment_or_claim_last_invalidated_reason,
    {{ appointment_is_nuida("appointment_or_claim_is_invalidated", "appointment_or_claim_seeker_feedback_type", "appointment_or_claim_ambassador_feedback_type") }} AS appointment_or_claim_is_nuida
FROM
    {{ ref('int__marketplace__appointments_and_claims') }}
