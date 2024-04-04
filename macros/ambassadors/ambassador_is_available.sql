{% macro ambassador_is_available(soft_deleted, invalidated, restricted, published, hibernated, iced_up, unavailable_until) -%}
case
    when {{soft_deleted}} = true then false
    when {{invalidated}} = true then false
    when {{restricted}} = true then false
    when {{published}} = false then false
    when {{hibernated}} = true then false
    when {{iced_up}} = true then false
    when {{unavailable_until}} is not null then false
    else true
end
{%- endmacro %}
