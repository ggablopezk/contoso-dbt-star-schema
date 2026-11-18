

select orderkey, linenumber, netprice, unitprice
from {{ ref('fct_sales') }}
WHERE netprice > unitprice
