-- Intermediate model: User activity summary with derived metrics

WITH users AS (
    SELECT * FROM {{ ref('stgusers') }}
),

activity AS (
    SELECT
        user_id,
        signup_date,
        plan_type,
        usage_count,
        is_converted,
        is_churned,
        CASE
            WHEN usage_count = 0 THEN 'no activity'
            WHEN usage_count BETWEEN 1 AND 25 THEN 'low'
            WHEN usage_count BETWEEN 26 AND 100 THEN 'medium'
            WHEN usage_count > 100 THEN 'high'
        END AS activity_level,
        CASE
            WHEN plan_type = 'Free' AND is_churned = TRUE THEN 'high risk'
            WHEN plan_type = 'Free' AND is_converted = FALSE THEN 'needs attention'
            WHEN plan_type IN ('Basic', 'Pro') AND is_churned = FALSE THEN 'healthy'
            WHEN plan_type = 'Enterprise' THEN 'premium'
            ELSE 'other'
        END AS user_segment
    FROM users
)

SELECT * FROM activity