{{ config(materialized='view') }}

SELECT
    user_id,
    last_program_end_at,
    is_currently_involved_in_a_fdr AS user_is_currently_involved_in_a_fdr,
    is_all_time_involved_in_a_fdr AS user_is_all_time_involved_in_a_fdr,
    nb_of_associated_programs,
    program_names
FROM
    {{ source('dbt-transformations', 'dim_seekers_participations') }}