{% macro appointment_individual_status(unbooked_column_name, status_column_name) %}
CASE
  WHEN {{unbooked_column_name}} = true THEN 'unbooked'
  WHEN {{status_column_name}} IS NULL THEN 'awaiting_review'
  WHEN {{status_column_name}} = 0 THEN 'awaiting_review'
  WHEN {{status_column_name}} = 1 THEN 'took_place'
  WHEN {{status_column_name}} = 2 THEN 'cancelled'
  WHEN {{status_column_name}} = 3 THEN 'did_not_show_up'
  WHEN {{status_column_name}} = 4 THEN 'forgot_to_go'
  WHEN {{status_column_name}} = 5 THEN 'rescheduled'
  WHEN {{status_column_name}} = 6 THEN 'was_not_scheduled'
  WHEN {{status_column_name}} = 7 THEN 'did_not_take_place_custom_reason'
END
{% endmacro %}
