{{ config(materialized='view') }}

SELECT
    user_id,
    first_name AS user_first_name,
    last_name AS user_last_name,
    user_normalized_phone,
    is_ambivalent AS user_is_ambivalent,
    situation AS user_situation,
    is_subscribed_to_red_carpets AS user_is_subscribed_to_red_carpets,
    is_user_soft_deleted AS user_is_soft_deleted,
    is_user_anonymized AS user_is_anonymized,
    dbt_scd_id,
    dbt_updated_at,
    dbt_valid_from,
    dbt_valid_to
FROM
    {{ source('dbt-transformations', 'snapshot_ambivalence') }}
