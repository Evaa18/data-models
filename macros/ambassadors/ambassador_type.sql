{% macro ambassador_type(column_name) -%}
CASE {{column_name}}
  WHEN 'Mentor' THEN 'Mentor'
  WHEN 'Company::Employee' THEN 'Ambassador'
  WHEN 'VIP' THEN 'VIP'
END
{% endmacro %}
