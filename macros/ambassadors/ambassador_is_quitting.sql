{% macro ambassador_is_quitting(soft_deleted, invalidated, restricted, published, hibernated, iced_up) -%}
CASE
    WHEN {{soft_deleted}} = TRUE THEN FALSE
    WHEN {{invalidated}} = TRUE THEN TRUE
    WHEN {{restricted}} = TRUE THEN FALSE
    WHEN {{published}} = FALSE THEN TRUE
    WHEN {{hibernated}} = TRUE THEN FALSE
    WHEN {{iced_up}} = TRUE THEN TRUE
    ELSE TRUE
END
{%- endmacro %}
