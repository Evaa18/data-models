{{ config(materialized='view') }}

SELECT
    _id AS appointment_id,
    professional_id AS ambassador_id,
    seeker_id,
    conversation_id,
    appointment_claim_id AS appointment_claim_id,
    created_at AS appointment_created_on_platform_at,
    updated_at AS appointment_updated_at,
    appointments.from AS appointment_start_at,
    appointments.to AS appointment_end_at,
    unbooked_at AS appointment_unbooked_at,
    last_invalidated_at AS appointment_last_invalidated_at,
    last_appointment_review_chased_at AS appointment_last_feedback_follow_up_sent_at,
    {{ appointment_type('type_cd') }} AS appointment_type,
    address_dataset AS appointment_address,
    meeting_place AS appointment_meeting_place,
    coordinates AS appointment_coordinates,
    time_zone AS appointment_time_zone,
    {{ appointment_general_status('unbooked', 'general_status_cd') }} AS appointment_general_status,
    {{ appointment_individual_status('unbooked', 'initiator_status_cd') }} AS appointment_seeker_feedback_type,
    {{ appointment_individual_status('unbooked', 'recipient_status_cd') }} AS appointment_ambassador_feedback_type,
    initiator_other_cancelled_description AS appointment_seeker_custom_cancellation_reason,
    recipient_other_cancelled_description AS appointment_ambassador_custom_cancellation_reason,
        STRUCT(
            review_from_professional._id AS ambassador_review_id,
            review_from_professional.feedback AS semi_public_comment_for_seeker,
            review_from_professional.message_for_hr,
            review_from_professional.snoozed AS was_snoozed,
            review_from_professional.must_be_completed_after,
            review_from_professional.reviewed_at,
            review_from_professional.rating AS legacy_rating,
            review_from_professional.question_1,
            review_from_professional.question_2,
            review_from_professional.question_3
        ) AS appointment_feedback_from_ambassador,
        STRUCT(
            review_from_student._id AS seeker_review_id,
            review_from_student.liked AS has_liked_appointment,
            review_from_student.message_for_professional AS message_for_ambassador,
            review_from_student.snoozed AS was_snoozed,
            review_from_student.must_be_completed_after,
            review_from_student.reviewed_at,
            review_from_student.question_1,
            review_from_student.question_2,
            review_from_student.question_3,
            review_from_student.want_to_be_recontacted AS is_willing_to_be_recontacted_for_opportunities,
            STRUCT (
                review_from_student.aspiration.type_cd AS opportunity_type,
                review_from_student.aspiration.duration_cd AS opportunity_duration,
                review_from_student.aspiration.starts_at_month,
                review_from_student.aspiration.starts_at_year,
                review_from_student.aspiration.postal_code
            ) AS opportunity_search
        ) AS appointment_feedback_from_seeker,
        invalidated AS appointment_is_invalidated,
        invalidated_reason AS appointment_last_invalidated_reason,
        appointment_review_chases AS appointment_feedback_follow_ups
FROM
    {{ source('marketplace', 'appointments') }}
