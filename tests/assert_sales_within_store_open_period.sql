

SELECT orderkey, linenumber, s.storekey, s.orderdate, st.closedate
FROM {{ref('fct_sales')}} AS s
LEFT JOIN {{ref('dim_store')}} AS st ON s.storekey = st.storekey
WHERE orderdate > closedate OR orderdate < opendate