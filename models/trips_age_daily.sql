with date_age_cte as (
	select
	    date(t.started_at) as date,
	    extract(year from t.started_at) - extract(year from u.birth_date) as age,
        price_rub
	from {{ ref("trips_prep") }} t
	inner join {{ source("scooters_raw", "users") }} u
		on t.user_id = u.id
)
select
    date,
    age,
    count(*) as trips,
    sum(price_rub) as revenue_rub 
from date_age_cte
group by
    date,
    age