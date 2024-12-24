with trips_cte as (
	select
		t2.company,
		count(t1.id) as trips
	from {{ ref("trips_prep") }} t1
	left join {{ ref("scooters") }} t2
		on t1.scooter_hw_id = t2.hardware_id
	group by company
)
select 
	t1.company,
	t1.trips,
	t2.scooters,
	t1.trips / cast(t2.scooters as float) as trips_per_scooter
from trips_cte t1
left join {{ ref("companies") }} t2
	on t1.company = t2.company