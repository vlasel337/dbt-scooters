{% macro trips_geom_stat(trips_table, geom_col, grid ) %}
    select
        st_transform(hex.geom, 4326) as geom,
        count(*) as trips
    from {{ trips_table }}
    cross join st_hexagongrid({{ grid }}, st_transform({{ geom_col }}, 3857)) as hex
    where 1=1
        and st_intersects(st_transform({{ geom_col }}, 3857), hex.geom)
    group by
        st_transform(hex.geom, 4326)
{% endmacro %}