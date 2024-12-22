

select
    t1.id, 
	t1.user_id, 
	t1.scooter_hw_id, 
	t1.started_at, 
	t1.finished_at, 
	t1.duration_s,
	t1.start_lat, 
	t1.start_lon, 
	t1.finish_lat, 
	t1.finish_lon, 
	t1.distance_m, 
	t1.price_rub,
	t1.is_free,
	t1.date,
    t2.sex,
    extract(year from t1.started_at) - extract(year from t2.birth_date) as age
from {{ ref("trips_prep") }} t1
left join {{ source("scooters_raw", "users")}} t2 
    ON t1.user_id = t2.id

{% if is_incremental() %}
where 1=1 
    and t1.id > (select max(id) from {{ this }})
order by t1.id
limit 75000

{% else %}
where 1=1
    and t1.id <= 75000

{% endif %}