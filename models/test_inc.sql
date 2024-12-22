{% if is_incremental() %}
select
    'INCREMENTAL' as run_type,
    now() as created_at
{% else %}
select
    'normal' as run_type,
    now() as created_at
{% endif %}