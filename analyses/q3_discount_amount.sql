-- Q3: How much revenue did we give up in discounts?
-- discount = gross (list price) - net (price actually charged), in USD.
-- pct_discount = sum(discount) / sum(gross sales), as a ratio (0.05 = 5%).
-- Split by year to see whether discounting is growing over time.

SELECT
	d.year,
	ROUND(SUM(s.gross_sale_amount_usd - s.net_sale_amount_usd)::numeric, 2) AS discount_amount_usd,
	ROUND(SUM(s.gross_sale_amount_usd - s.net_sale_amount_usd)::numeric / SUM(s.gross_sale_amount_usd)::numeric, 3) AS pct_discount
FROM {{ ref('fct_sales') }} AS s
LEFT JOIN {{ ref('dim_date') }} AS d ON d.date = s.orderdate
GROUP BY 1
ORDER BY 1
