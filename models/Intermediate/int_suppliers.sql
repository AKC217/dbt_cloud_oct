{{ config(
    materialized = 'dynamic_table',
    target_lag = '10 minutes',
    snowflake_warehouse = 'TRANSFORM_WH'
) }}

WITH dy AS (
    SELECT
        s.supplier_id AS supplier_id,
        s.supplier_name AS supplier_name,
        s.nation_id AS nation_id,
        s.account_balance AS account_balance,
        s.supplier_address AS supplier_address,
        s.phone_number AS phone_number,
        s.comment AS supplier_comment,   -- FIXED COLUMN NAME
        s.updated_time AS last_updated_at,

        CASE 
            WHEN s.account_balance > 1000 THEN 'High Value Supplier'
            WHEN s.account_balance BETWEEN 0 AND 1000 THEN 'Regular Supplier'
            ELSE 'Low Balance Supplier'
        END AS supplier_type

    FROM {{ ref('stg_suppliers') }} s
)

SELECT * FROM dy
