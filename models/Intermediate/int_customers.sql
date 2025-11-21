{{ config(
    materialized = "view"
) }}

WITH customers AS (
    SELECT
        CUSTOMER_ID      AS customer_id,
        NAME             AS customer_name,
        ADDRESS          AS customer_address,
        NATION_ID        AS nation_id,
        PHONE_NUMBER     AS phone_number,
        ACCOUNT_BALANCE  AS account_balance,
        MARKET_SEGMENT   AS market_segment,
        COMMENT          AS customer_comment
    FROM {{ ref('stg_customers') }}
),

nations AS (
    SELECT
        nation_id,
        nation_name,
        region_id,
        updated_at AS nation_updated_at
    FROM {{ ref('stg_nations') }}
),

regions AS (
    SELECT
        region_id,
        region_name,
        region_comment
    FROM {{ ref('stg_regions') }}
),

final AS (
    SELECT
        -- Customer columns
        c.customer_id,
        c.customer_name,
        c.customer_address,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        c.customer_comment,
        c.nation_id,

        -- Nation columns
        n.nation_name,
        n.region_id,
        n.nation_updated_at,

        -- Region columns
        r.region_name,
        r.region_comment

    FROM customers c
    JOIN nations n 
        ON c.nation_id = n.nation_id
    JOIN regions r
        ON n.region_id = r.region_id
)

SELECT * FROM final;
