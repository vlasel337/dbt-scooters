
select
	DATE(started_at) as date,
	count(*) as trips,
	max(price)/100 as max_price_rub,
	avg(distance)/1000 as avg_distance_km
from scooters_raw.trips
group by 
	DATE(started_at)
order by 
	DATE(started_at)