{{ config( alias= this.name + var('v_id'),
access ='private')}}

with nation as (select 
    n_nationkey as nation_id,
    n_name as name,
    n_regionkey as region_id,
    current_timestamp() as updated_at
from {{ source('src', 'nations') }}
)
select * from nation
