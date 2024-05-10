{% macro ambassador_is_available(soft_deleted, invalidated, restricted, published, hibernated, iced_up, unavailable_until) -%}
CASE
    WHEN {{soft_deleted}} = TRUE THEN FALSE
    WHEN {{invalidated}} = TRUE THEN FALSE
    WHEN {{restricted}} = TRUE THEN FALSE
    WHEN {{published}} = FALSE THEN FALSE
    WHEN {{hibernated}} = TRUE THEN FALSE
    WHEN {{iced_up}} = TRUE THEN FALSE
    WHEN {{unavailable_until}} IS NOT NULL THEN FALSE
    ELSE TRUE
END
{%- endmacro %}
