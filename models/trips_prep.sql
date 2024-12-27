select
	id, 
	user_id, 
	scooter_hw_id, 
	started_at, 
	finished_at, 
	extract(epoch from (finished_at - started_at)) as duration_s,
	start_lat, 
	start_lon, 
	finish_lat, 
	finish_lon, 
	distance as distance_m, 
	cast(price as decimal(20, 2)) / 100 as price_rub,
	cast(case when price = 0 and finished_at > started_at then 1 else 0 end as boolean) as is_free,
	{{ date_in_moscow('started_at') }} as "date"
from {{ source("scooters_raw","trips") }}