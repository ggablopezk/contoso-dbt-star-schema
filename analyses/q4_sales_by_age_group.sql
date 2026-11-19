-- Q4: Which age group buys the most?
-- Uses the customer's age at the time of the order (fct_sales.customer_age_at_order),
-- not dim_customer.age_group, which is based on current age.
-- Measured as net sales in USD and number of distinct customers.
-- Note: a customer can appear in two age groups if they bought at different ages,
-- so uq_customers should not be summed across groups.

WITH sales_with_age_group AS (
	SELECT
		*,
		CASE
			WHEN customer_age_at_order < 18 THEN '-18'
			WHEN customer_age_at_order BETWEEN 18 AND 25 THEN '18-25'
			WHEN customer_age_at_order BETWEEN 26 AND 33 THEN '26-33'
			WHEN customer_age_at_order BETWEEN 34 AND 41 THEN '34-41'
			WHEN customer_age_at_order BETWEEN 42 AND 49 THEN '42-49'
			WHEN customer_age_at_order BETWEEN 50 AND 57 THEN '50-57'
			WHEN customer_age_at_order BETWEEN 58 AND 65 THEN '58-65'
			WHEN customer_age_at_order >= 66 THEN '+66'
			ELSE 'No data'
		END AS age_group_at_order
	FROM {{ ref('fct_sales') }}
)

SELECT
	age_group_at_order,
	ROUND(SUM(net_sale_amount_usd)::numeric, 2) AS net_sale_usd,
	COUNT(DISTINCT customerkey) AS uq_customers
FROM sales_with_age_group
GROUP BY 1
ORDER BY 2 DESC
