{{ config( alias= this.name + var('v_id') )}}

with nation as (select 
    n_nationkey as nation_id,
    n_name as name,
    n_regionkey as region_id,
    current_timestamp() as updated_at
from {{ source('src', 'nations') }}
)
select * from nation

-- with nations as (
--     select 
--         n_nationkey as nation_id,
--         n_name as name,
--         n_regionkey as region_id,
--         n_comment as comment,
--         {{ jodo('n_name', 'n_comment') }} as jodo_col,
--         current_timestamp() as updated_at
--     from {{ source('src', 'nations') }}
-- )

-- select *
-- from nations



-- with nations as (
--     select 
--         n_nationkey as nation_id,
--         n_name as name,
--         n_regionkey as region_id,
--         n_comment as comment
--     from {{ source('src', 'nations') }}
-- )

-- select * 
-- from nations

