{{ config(
    alias = this.name ~ var('v_id'),
    access = 'private'
) }}

WITH customers AS (
    SELECT
        id,
        customer,

        -- Adds the run start timestamp (UTC by default)
        '{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S") }}' AS run_started_at_utc,

        -- Unique dbt invocation ID for auditing
        '{{ invocation_id }}' AS invocation_id

    FROM {{ source('src', 'customers') }}
)

SELECT *
FROM customers;
