{{ config(materialized='view') }}

SELECT
    professional_id AS ambassador_id,
    company_id,
    denormalized_becomes_available_or_iced_up_at AS ambassador_becomes_available_or_iced_up_at,
    denormalized_is_unavailable_from_monthly_quota_cached_at AS ambassador_is_unavailable_from_monthly_quota_cached_at,
    company_name AS ambassador_company_name,
    professional_type AS ambassador_type,
    professional_current_status AS ambassador_status,
    is_professional_visible AS ambassador_is_visible,
    is_professional_available AS ambassador_is_available,
    is_hibernated AS ambassador_is_hibernated,
    is_published AS ambassador_is_published,
    is_iced_up AS ambassador_is_iced_up,
    is_soft_deleted AS ambassador_is_soft_deleted,
    max_appointments_per_month AS ambassador_max_appointments_per_month,
    dbt_updated_at,
    dbt_valid_from,
    dbt_valid_to
FROM
    {{ source('dbt-transformations', 'snapshot_professionals_status') }}