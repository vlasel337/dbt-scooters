
with inner_tab as (
	select 
		DATE(t1.started_at) as date,
		EXTRACT(YEAR FROM t1.started_at) - EXTRACT(YEAR FROM t2.birth_date) as age,
		count(*) as cnt_rides
	from scooters_raw.trips t1
	inner join scooters_raw.users t2
		on t1.user_id = t2.id
	group by 
		DATE(t1.started_at),	
		EXTRACT(YEAR FROM t1.started_at) - EXTRACT(YEAR FROM t2.birth_date)
)
select 
	age,
	avg(cnt_rides) as avg_rides
from inner_tab
group by 
	age
order by 
	age