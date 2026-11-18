
{{ config(materialized='table') }}




with customers as (
    select * from {{ ref('stg_customer') }}
),

aging as (
    select
        *,
        date_part('year', age(current_date, birthday))::int AS current_age
    from customers
),

final as (
    select
        *,
        CASE
        WHEN current_age < 18 THEN '-18'
		WHEN current_age BETWEEN 18 AND 25 THEN '18-25'
		WHEN current_age BETWEEN 26 AND 33 THEN '26-33'
		WHEN current_age BETWEEN 34 AND 41 THEN '34-41'
		WHEN current_age BETWEEN 42 AND 49 THEN '42-49'
		WHEN current_age BETWEEN 50 AND 57 THEN '50-57'
		WHEN current_age BETWEEN 58 AND 65 THEN '58-65'
		WHEN current_age >= 66 THEN '+66'
		ELSE 'No data'
		END AS age_group
    from aging
)

select * from final