{{ config(materialized='table') }}

WITH first_conversation AS (
    SELECT
        user_id,
        MIN(conversation_initiated_at) AS first_conversation_start_at
    FROM
        {{ ref('base__marketplace__users') }} AS users
    LEFT JOIN
        {{ ref('base__marketplace__conversations') }} AS conversations
        ON conversations.seeker_user_id = users.user_id
    GROUP BY ALL
)

SELECT
    user_id,
    seeker_id,
    COALESCE(
        LEAST(
            ambassador_first_published_at,
            first_conversation_start_at
        ),
        first_conversation_start_at
    ) AS member_activated_at
FROM
    {{ ref('base__marketplace__users') }} AS users
LEFT JOIN
    first_conversation
    USING(user_id)
LEFT JOIN
    {{ ref('base__marketplace__ambassadors') }} AS ambassadors
    USING(user_id)
LEFT JOIN
     {{ ref('base__marketplace__seekers') }} AS seekers
    USING(user_id)
