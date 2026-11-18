
select orderkey, linenumber, count(*)
from {{ ref('fct_sales') }}
group by 1, 2
having count(*) > 1

