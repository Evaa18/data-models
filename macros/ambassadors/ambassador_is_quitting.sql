{% macro ambassador_is_quitting(soft_deleted, invalidated, restricted, published, hibernated, iced_up) -%}
case
    when {{soft_deleted}} = true then false
    when {{invalidated}} = true then true
    when {{restricted}} = true then false
    when {{published}} = false then true
    when {{hibernated}} = true then false
    when {{iced_up}} = true then true
    else true
end
{%- endmacro %}
