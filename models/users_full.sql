with first_name_sex_cte as (
	select distinct
		first_name,
		sex
	from {{ source("scooters_raw", "users") }}
	where sex is not null
	
	union
	
	select 
		first_name,
		sex
	from {{ ref("names_for_sex") }}
)
select 
	t1.id, t1.first_name, t1.last_name, t1.phone, coalesce(t1.sex,t2.sex) as sex, t1.birth_date
from {{ source("scooters_raw", "users") }} t1
left join first_name_sex_cte t2
	on t1.first_name = t2.first_name