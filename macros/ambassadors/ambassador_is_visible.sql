{% macro ambassador_is_visible(soft_deleted, invalidated, restricted, published, hibernated, iced_up) -%}
case
    when {{soft_deleted}} = true then false
    when {{invalidated}} = true then false
    when {{restricted}} = true then false
    when {{published}} = false then false
    when {{hibernated}} = true then true
    when {{iced_up}} = true then false
    else true
end
{%- endmacro %}