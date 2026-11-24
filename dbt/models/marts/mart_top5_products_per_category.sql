-- 5 produk dengan pendapatan tertinggi di tiap kategori
select
    p.category,
    p.product_name,
    sum(f.total_amount) as revenue,
    row_number() over (
        partition by p.category                 -- ranking dihitung terpisah per kategori
        order by sum(f.total_amount) desc
    ) as rank_in_category
from {{ ref('fact_sales') }}  f
join {{ ref('dim_product') }} p on f.product_id = p.product_id
group by p.category, p.product_name
qualify rank_in_category <= 5              	-- QUALIFY = WHERE untuk window function (DuckDB)
order by p.category, rank_in_category