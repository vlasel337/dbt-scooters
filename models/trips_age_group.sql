with groups_cte as (
	select
		t1.id,
		t1.user_id,
		t1.price_rub,
		t1.is_free,
		t1.age,
		t2."group" as age_group
	from {{ ref("trips_users") }} t1
	left join {{ ref("age_groups") }} t2
		on t1.age between t2.age_start and t2.age_end 
)
select
	age_group,
	count(*) as trips,
	sum(price_rub) as revenue_rub
from groups_cte
group by age_group