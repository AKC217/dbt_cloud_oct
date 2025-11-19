{{ config(materialized='incremental') }}

with nation as (
    select 
        REGION_ID,
        NATION_ID,
        NAME as NATION_NAME,
        COMMENT,
        JODO_COL as JODO_NAME_COMMENT,
        CURRENT_TIMESTAMP() as UPDATED_AT
    from {{ ref('stg_nations') }}

    {% if is_incremental() %}
        where CURRENT_TIMESTAMP() > (
            select coalesce(max(UPDATED_AT), '1900-01-01'::timestamp)
            from {{ this }}
        )
    {% endif %}
)

select * from nation
