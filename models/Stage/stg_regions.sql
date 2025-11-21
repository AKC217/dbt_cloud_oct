
with region as (
    select
        r_regionkey as region_id,
        r_name1 as name,
        r_comment as comment
    from {{ source('src', 'regions') }}
)

select * 
from region 

