-- 10 pelanggan dengan total belanja terbesar
select
    c.customer_id,
    c.customer_name,
    c.region,
    sum(f.total_amount) as total_spending
from {{ ref('fact_sales') }}   f
join {{ ref('dim_customer') }} c on f.customer_id = c.customer_id
group by 1, 2, 3
order by total_spending desc
limit 10