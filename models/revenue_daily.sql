select 
    "date", 
    sum(price_rub) as revenue_rub,
    {{ updated_at() }}
from {{ ref("trips_prep") }}

{% if is_incremental() %}
where 1=1
    and "date" >= (select date(max("date")) - INTERVAL '2 days' from {{ this }})

{% endif %}
group by 
    "date", 
    now() at time zone 'utc'
order by "date"