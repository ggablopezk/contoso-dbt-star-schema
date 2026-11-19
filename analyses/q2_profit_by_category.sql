-- Q2: Which product categories generate the most profit?
-- Uses fct_sales.profit_amount_usd (net price after discount - cost, times quantity).
-- dim_product.unit_margin is not used: it is based on list price per unit,
-- so it ignores discounts and quantity sold.
-- pct_margin = sum(profit) / sum(net sales), as a ratio (0.45 = 45%).

SELECT
	d.categoryname,
	ROUND(SUM(s.profit_amount_usd)::numeric, 2) AS profit_usd,
	ROUND(SUM(s.profit_amount_usd)::numeric / SUM(s.net_sale_amount_usd)::numeric, 3) AS pct_margin
FROM {{ ref('fct_sales') }} AS s
LEFT JOIN {{ ref('dim_product') }} AS d ON d.productkey = s.productkey
GROUP BY 1
ORDER BY 2 DESC
