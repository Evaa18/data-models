{% macro appointment_is_nuida(invalidation_field, student_feedback_type_field, professional_feedback_type_field) -%}
{{ invalidation_field }} IS FALSE AND (
    {{ student_feedback_type_field }} = 'upcoming_or_pending_review'
    OR {{ student_feedback_type_field }} = 'took_place'
    OR {{ student_feedback_type_field }} = 'awaiting_review'
) AND (
    {{ professional_feedback_type_field }} = 'upcoming_or_pending_review'
    OR {{ professional_feedback_type_field }} = 'took_place'
    OR {{ professional_feedback_type_field }} = 'awaiting_review'
)
{%- endmacro %}
