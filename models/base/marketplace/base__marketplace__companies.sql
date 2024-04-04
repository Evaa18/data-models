{{ config(materialized='view') }}

SELECT
    _id AS company_id
FROM
    {{ source('marketplace', 'companies') }}
