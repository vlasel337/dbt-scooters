select distinct
	user_id, 
	timestamp, 
	type_id
from {{ source("scooters_raw", "events") }}
{% if is_incremental() %}
where 1=1
    and timestamp > (select max(timestamp) from {{ this }})
    -- and timestamp <= (select date(max("timestamp")) + interval '2' month from {{ this }})
{% else %}
where 1=1
    and timestamp < '2023-08-01'
{% endif %}
