{{ config(materialized='table') }}

with date as (
    select * from {{ ref('stg_date') }}
),

weekend_day as (
    select
        *,
        dayofweek in ('Saturday', 'Sunday') as is_weekend
    FROM date
),

final as (
    select
        *
    from weekend_day
)

select * from final