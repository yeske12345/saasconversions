-- Fact table: Conversion metrics by plan and month

WITH activity AS (
    SELECT * FROM {{ ref('intuseractivity') }}
),

monthly AS (
    SELECT
        DATE_TRUNC('month', signup_date) AS signup_month,
        plan_type,
        COUNT(*) AS total_users,
        SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END) AS converted_users,
        SUM(CASE WHEN is_churned = TRUE THEN 1 ELSE 0 END) AS churned_users,
        ROUND(AVG(usage_count), 0) AS avg_usage
    FROM activity
    GROUP BY signup_month, plan_type
)

SELECT * FROM monthly