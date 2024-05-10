{% macro ambassador_is_industry_ambassador(company_id_column = 'company_id') -%}
COALESCE({{ company_id_column }}, 'no_company_id') in (
  '651e812faeb44600b85bab5d', {#- https://api.myjobglasses.com/admin/companies/industrie_aeronautique_et_spatiale #}
  '655e293430c78700b6b2d28a'  {#- https://api.myjobglasses.com/admin/companies/industrie_agroalimentaire_agriculture_peche_et_territoires #}
)
{%- endmacro %}
