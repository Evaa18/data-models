{% macro appointment_type(status_column_name) %}
CASE
  WHEN {{status_column_name}} = 0 THEN 'phone'
  WHEN {{status_column_name}} = 1 THEN 'video'
  WHEN {{status_column_name}} = 2 THEN 'face_to_face'
END
{% endmacro %}
