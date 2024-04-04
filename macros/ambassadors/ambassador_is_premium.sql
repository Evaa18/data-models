{% macro ambassador_is_premium(ambassador_type_column = 'ambassador_type') -%}
{{ ambassador_type_column }} IN ('Ambassador', 'VIP')
{%- endmacro %}
