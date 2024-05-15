{# https://www.notion.so/myjobglasses/Member-classifications-type-role-ambivalence-8c80c52953d04d538f3e4f65dc6cb9af?pvs=4 -#}
{% macro member_primary_type(is_school_teacher_column, is_france_travail_job_seeker_column, is_oriane_ambassador_column, is_affiliated_to_any_vocation_program_column, situation_column, account_created_at_column) -%}
CASE
    WHEN {{is_school_teacher_column}} = true THEN 'school_teacher'
    WHEN {{is_france_travail_job_seeker_column}} = true THEN 'france_travail'
    WHEN {{is_oriane_ambassador_column}} = true THEN 'oriane_ambassador'
    WHEN {{is_affiliated_to_any_vocation_program_column}} = true THEN 'affiliated_to_vocation_program'
    WHEN {{situation_column}} = 'graduate_student'
      OR (
        {{situation_column}} = 'undefined'
        AND {{account_created_at_column}} < {{ambassadors_can_also_be_members_release_date()}}
      ) THEN 'non_affiliated_graduate_student'
    WHEN {{situation_column}} in ('senior_high_school_student', 'junior_high_school_student') THEN 'non_affiliated_high_school_student'
    WHEN {{situation_column}} = 'in_activity' THEN 'in_activity'
    ELSE 'undefined'
END
{% endmacro %}