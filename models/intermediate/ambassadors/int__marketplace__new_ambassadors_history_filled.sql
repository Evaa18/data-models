{{ config(materialized='table') }}

SELECT
    *
FROM
    GAP_FILL(
        (SELECT * FROM {{ ref('int__marketplace__ambassadors_history') }}),
        ts_column => 'dbt_valid_from',
        bucket_width => INTERVAL 1 DAY,
        partitioning_columns => ['ambassador_id','ambassador_classification','ambassador_company_name','company_sector_name','ambassador_job_title','address_country','address_administrative_area_level_1_region_fr','address_administrative_area_level_2_department_fr','address_city_fr', 'address_postal_code'],
        value_columns => [
            ('new_ambassador_is_published','null')
        ]
    )
