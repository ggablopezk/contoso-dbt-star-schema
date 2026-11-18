SELECT orderkey, linenumber, deliverydate, orderdate
FROM {{ ref('stg_sales') }}
WHERE deliverydate < orderdate




