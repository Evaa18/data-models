{% macro company_size(column_name) %}
CASE
  WHEN {{column_name}} = 'only_one' THEN '1 (independent/anto-entrepreneur)'
  WHEN {{column_name}} = 'under_10' THEN 'between 2 and 9 (included)'
  WHEN {{column_name}} = 'under_50' THEN 'between 10 and 49 (included)'
  WHEN {{column_name}} = 'under_200' THEN 'between 50 and 199 (included)'
  WHEN {{column_name}} = 'under_500' THEN 'between 200 and 499 (included)'
  WHEN {{column_name}} = 'under_1000' THEN 'between 500 and 999 (included)'
  WHEN {{column_name}} = 'under_5000' THEN 'between 1.000 and 4.999 (included)'
  WHEN {{column_name}} = 'under_10000' THEN 'between 5.000 and 9.999'
  WHEN {{column_name}} = 'over_10000' THEN 'more than 10.000'
  WHEN {{column_name}} = 'unknown' THEN 'unknown'
  WHEN {{column_name}} IS NULL THEN 'unknown'
END
{% endmacro %}
