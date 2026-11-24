-- penjualan per wilayah per bulan
select
    c.region,
    date_trunc('month', f.date_key)::date as sales_month,   -- date_key = tanggal order; dipotong ke awal bulan
    sum(f.total_amount)                   as revenue,
    sum(f.quantity)                       as units_sold
from {{ ref('fact_sales') }}   f
join {{ ref('dim_customer') }} c on f.customer_id = c.customer_id   -- join ke dim_customer untuk dapat region
group by 1, 2
order by 1, 2