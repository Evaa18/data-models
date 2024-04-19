{{ config(materialized='view') }}

SELECT
    date AS targeted_at,
    CASE
        WHEN audience = 'ambassadeur_filiere' THEN 'industry'
        WHEN audience = 'ambassadeur_premium_hors_filiere' THEN 'premium_except_industry'
        WHEN audience = 'ambassadeur_free_hors_jeunes' THEN 'ambassadors_except_youth'
        WHEN audience = 'ambassadeur_jeune_nouveau' THEN 'youth_ambassadors_new'
        WHEN audience = 'ambassadeur_jeune_ambivalent' THEN 'youth_ambassadors'
    ELSE NULL
    END AS ambassador_classification,
    objective_value AS target_value__published_ambassadors
FROM
    {{ source('google-sheets', 'target_published_ambassadors') }}
