{% macro ambassador_is_visible(soft_deleted, invalidated, restricted, published, hibernated, iced_up) -%}
CASE
    WHEN {{soft_deleted}} = TRUE THEN FALSE
    WHEN {{invalidated}} = TRUE THEN FALSE
    WHEN {{restricted}} = TRUE THEN FALSE
    WHEN {{published}} = FALSE THEN FALSE
    WHEN {{hibernated}} = TREU THEN TRUE
    WHEN {{iced_up}} = TRUE THEN FALSE
    ELSE TRUE
END
{%- endmacro %}