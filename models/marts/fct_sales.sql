{{ config(materialized='table') }}

-- Sales fact table. Grain: one row per order line (orderkey + linenumber).
-- Prices in stg_sales are already in USD; exchangerate converts USD -> local currency.

with sales as (

    select * from {{ ref('stg_sales') }}

),

customers as (

    select customerkey, birthday from {{ ref('stg_customer') }}

),

amounts as (

    select
        *,
        quantity * unitprice as gross_sale_amount_usd,
        quantity * netprice  as net_sale_amount_usd,
        quantity * unitcost  as total_cost_amount_usd
    from sales

),

final as (

    select
        -- grain
        a.orderkey,
        a.linenumber,

        -- foreign keys
        a.customerkey,
        a.storekey,
        a.productkey,
        a.orderdate,

        -- base measures (USD)
        a.quantity,
        a.unitprice,
        a.netprice,
        a.unitcost,

        -- currency
        a.currencycode,
        a.exchangerate,

        -- amounts (USD)
        a.gross_sale_amount_usd,
        a.net_sale_amount_usd,
        a.total_cost_amount_usd,
        (a.net_sale_amount_usd - a.total_cost_amount_usd) as profit_amount_usd,

        -- amount in the customer's local currency
        a.net_sale_amount_usd * a.exchangerate as net_sale_amount_local,

        -- customer age
        date_part('year', age(a.orderdate, c.birthday))::int as customer_age_at_order

    from amounts as a
    left join customers as c
        on c.customerkey = a.customerkey

)

select * from final
