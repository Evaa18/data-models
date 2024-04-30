{% macro appointment_general_status(unbooked_column_name, status_column_name) %}
CASE
  WHEN {{unbooked_column_name}} = true THEN 'unbooked'
  WHEN {{status_column_name}} IS NULL THEN 'upcoming_or_pending_review'
  WHEN {{status_column_name}} = 0 THEN 'upcoming_or_pending_review'
  WHEN {{status_column_name}} = 1 THEN 'cancelled'
  WHEN {{status_column_name}} = 2 THEN 'took_place'
  WHEN {{status_column_name}} = 3 THEN 'conflict'
  WHEN {{status_column_name}} = 4 THEN 'both_forgot_to_go'
  WHEN {{status_column_name}} = 5 THEN 'rescheduled'
  WHEN {{status_column_name}} = 6 THEN 'stood_up_by_student'
  WHEN {{status_column_name}} = 7 THEN 'stood_up_by_professional'
END
{% endmacro %}
