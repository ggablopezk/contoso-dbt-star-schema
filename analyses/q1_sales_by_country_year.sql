-- Q1: How much did we sell by country and year, in USD?
-- Country = country of the store (dim_store), not of the customer:
-- it best reflects where the sale happened.
-- Uses net_sale_amount_usd, which is safe to sum across currencies.

SELECT
	d.year,
	e.countryname AS country,
	ROUND(SUM(s.net_sale_amount_usd)::numeric, 2) AS net_sale_usd
FROM {{ ref('fct_sales') }} AS s
LEFT JOIN {{ ref('dim_date') }} AS d ON d.date = s.orderdate
LEFT JOIN {{ ref('dim_store') }} AS e ON e.storekey = s.storekey
GROUP BY 1, 2
ORDER BY 1, 2
