-- pertumbuhan pendapatan bulan ke bulan (MoM)
with monthly as (
    select date_trunc('month', date_key)::date as sales_month,
           sum(total_amount)                   as revenue
    from {{ ref('fact_sales') }}
    group by 1
)
select
    sales_month,
    revenue,
    lag(revenue) over (order by sales_month) as prev_revenue,    	-- pendapatan bulan sebelumnya
    round(
        (revenue - lag(revenue) over (order by sales_month)) * 100.0
        / nullif(lag(revenue) over (order by sales_month), 0),   	-- nullif: hindari bagi nol
    2) as growth_pct
from monthly
order by sales_month