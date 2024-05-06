{% macro member_secondary_type(member_type_column, situation_column, is_also_published_ambassador_column) -%}
CASE
    WHEN {{member_type_column}} IN ('affiliated_to_vocation_program', 'non_affiliated_graduate_student', 'non_affiliated_high_school_student') THEN {{situation_column}}
    WHEN {{member_type_column}} = 'school_teacher' THEN 'school_teacher'
    WHEN {{member_type_column}} = 'in_activity' AND {{is_also_published_ambassador_column}} = true THEN 'member_also_published_as_ambassador'
    WHEN {{member_type_column}} = 'in_activity' AND {{is_also_published_ambassador_column}} = false THEN 'only_member'
    ELSE 'undefined'
END
{% endmacro %}