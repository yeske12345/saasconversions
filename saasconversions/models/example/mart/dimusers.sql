-- Dimension table: User attributes with activity segments

SELECT
    user_id,
    signup_date,
    plan_type,
    usage_count,
    is_converted,
    is_churned,
    activity_level,
    user_segment
FROM {{ ref('intuseractivity') }}