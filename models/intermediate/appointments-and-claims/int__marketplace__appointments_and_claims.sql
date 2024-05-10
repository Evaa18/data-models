{{ config(materialized='table') }}

SELECT
    appointment_id AS appointment_or_claim_id,
    ambassador_id,
    seeker_id,
    conversation_id,
    appointment_created_on_platform_at AS appointment_or_claim_created_on_platform_at,
    appointment_updated_at AS appointment_or_claim_updated_at,
    appointment_start_at AS appointment_start_at,
    appointment_unbooked_at AS appointment_unbooked_at,
    appointment_last_invalidated_at AS appointment_last_invalidated_at,
    'appointment' AS appointment_or_claim,
    appointment_type AS appointment_type,
    appointment_time_zone AS appointment_time_zone,
    appointment_address AS appointment_address,
    appointment_meeting_place AS appointment_meeting_place,
    appointment_coordinates AS appointment_coordinates,
    appointment_general_status AS appointment_or_claim_general_status,
    appointment_seeker_feedback_type AS appointment_or_claim_seeker_feedback_type,
    appointment_ambassador_feedback_type AS appointment_or_claim_ambassador_feedback_type,
    appointment_feedback_from_ambassador AS appointment_feedback_from_ambassador,
    appointment_feedback_from_seeker AS appointment_feedback_from_seeker,
    appointment_is_invalidated AS appointment_is_invalidated,
    appointment_last_invalidated_reason AS appointment_last_invalidated_reason
FROM
    {{ ref('base__marketplace__appointments') }} AS appointments
UNION ALL
SELECT
    appointment_claim_id AS appointment_or_claim_id,
    ambassador_id,
    seeker_id,
    conversation_id,
    appointment_claim_created_on_platform_at AS appointment_or_claim_created_on_platform_at,
    appointment_claim_updated_at AS appointment_or_claim_updated_at,
    appointment_start_at AS appointment_start_at,
    NULL AS appointment_unbooked_at,
    NULL AS appointment_last_invalidated_at,
    'appointment_claim' AS appointment_or_claim,
    appointment_type AS appointment_type,
    appointment_time_zone AS appointment_time_zone,
    appointment_address AS appointment_address,
    appointment_meeting_place AS appointment_meeting_place,
    appointment_coordinates AS appointment_coordinates,
    'upcoming_or_pending_review' AS appointment_or_claim_general_status,
    'upcoming_or_pending_review' AS appointment_or_claim_seeker_feedback_type,
    'upcoming_or_pending_review' AS appointment_or_claim_ambassador_feedback_type,
    NULL AS appointment_feedback_from_ambassador,
    NULL AS appointment_feedback_from_seeker,
    FALSE AS appointment_is_invalidated,
    NULL AS appointment_last_invalidated_reason
FROM
    {{ ref('base__marketplace__appointment_claims') }} AS appointment_claims
WHERE
    appointment_claim_status = 'pending'
