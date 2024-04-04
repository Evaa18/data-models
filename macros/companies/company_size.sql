{% macro company_size(column_name) %}
case
  when {{column_name}} = 'only_one' then '1 (independent/anto-entrepreneur)'
  when {{column_name}} = 'under_10' then 'between 2 and 9 (included)'
  when {{column_name}} = 'under_50' then 'between 10 and 49 (included)'
  when {{column_name}} = 'under_200' then 'between 50 and 199 (included)'
  when {{column_name}} = 'under_500' then 'between 200 and 499 (included)'
  when {{column_name}} = 'under_1000' then 'between 500 and 999 (included)'
  when {{column_name}} = 'under_5000' then 'between 1.000 and 4.999 (included)'
  when {{column_name}} = 'under_10000' then 'between 5.000 and 9.999'
  when {{column_name}} = 'over_10000' then 'more than 10.000'
  when {{column_name}} = 'unknown' then 'unknown'
  when {{column_name}} is null then 'unknown'
end
{% endmacro %}
