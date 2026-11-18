
{{ config(materialized='table') }}

with product as (
    select * from {{ ref('stg_product') }}
),

revenue as (
    select
        *,
        price - COST AS unit_margin,
        ROUND((price - COST)::numeric/NULLIF(price, 0)::NUMERIC,2)::numeric AS unit_margin_pct
    from product
),

final as (
    select
        *
    from revenue
)

select * from final