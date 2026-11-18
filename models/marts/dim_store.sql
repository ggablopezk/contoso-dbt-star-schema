{{ config(materialized='table') }}

with store as (
    select * from {{ ref('stg_store') }}
),

open_store as (
    select
        *,
        closedate is null as is_open
    FROM store
       
),

final as (
    select
        *
    from open_store
)

select * from final




