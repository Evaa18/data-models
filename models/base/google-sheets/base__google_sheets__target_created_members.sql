{{ config(materialized='view') }}

SELECT
    date AS targeted_at,
    CASE
        WHEN audience LIKE '%graduate_student%' THEN 'graduate_student'
        WHEN audience LIKE '%professional%' THEN 'in_activity'
        WHEN audience LIKE '%junior_high_school_student%' THEN 'junior_high_school_student'
        WHEN audience LIKE '%senior_high_school_student%' THEN 'senior_high_school_student'
        WHEN audience LIKE '%school_teacher%' THEN 'school_teacher'
    ELSE 'unsure'
    END AS member_type,
    SUM(objective_value) AS target_value__created_members
FROM
    {{ source('google-sheets', 'target_members') }}
WHERE
    type = 'created'
GROUP BY ALL
