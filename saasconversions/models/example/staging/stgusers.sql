-- Staging model: Cleans and standardizes raw SaaS user data

WITH source AS (
    SELECT * FROM {{ ref('rawusers') }}
),

cleaned AS (
    SELECT
        user_id,
        signup_date,
        plan_type,
        usage_count,
        CASE 
            WHEN converted = 'yes' THEN TRUE 
            ELSE FALSE 
        END AS is_converted,
        CASE 
            WHEN churned = 'yes' THEN TRUE 
            ELSE FALSE 
        END AS is_churned
    FROM source
)

SELECT * FROM cleaned