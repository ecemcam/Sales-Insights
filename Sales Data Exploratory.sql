--Data Explatory to confirm that data is showing properly in powerBI:


--To see the Sum of amount and quantity of the sales for a specific Customer at specific year and month.

with sum_per_year_and_customer as (select dt.year,dt.month_name,cs.customer_name,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr inner join date dt
									on tr.order_date = dt.order_date
									inner join  customers cs
									on tr.customer_code = cs.customer_code
									group by cs.customer_name, dt.year, dt.month_name)
select *from sum_per_year_and_customer
where customer_name ilike 'electricalsara stores' and year = 2017 and month_name ilike 'october';


--To see the Sum of amount and quantity of the sales for a specific Market at specific year and month.

with sum_per_year_and_market as (select dt.year,dt.month_name,mr.markets_name,sum(tr.sales_amount) as total_sale_amount, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr inner join date dt
									on tr.order_date = dt.order_date
									inner join  markets mr
									on tr.market_code= mr.market_code
									group by mr.markets_name, dt.year, dt.month_name)
select *from sum_per_year_and_market 
where markets_name ilike 'mumbai' and  year = 2018 and month_name ilike 'january';


--To see the Sum of amount and quantity of the sales for a specific Market at specific year.

with sum_per_year_and_market as (select dt.year,mr.markets_name,sum(tr.sales_amount) as total_sale_amount, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr inner join date dt
									on tr.order_date = dt.order_date
									inner join  markets mr
									on tr.market_code= mr.market_code
									group by mr.markets_name, dt.year)
select *from sum_per_year_and_market
where markets_name ilike 'mumbai' and  year = 2018;



--To see top 5 Customers who made the most Revenue.

with sum_per_customer as (select cs.customer_name,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  customers cs
									on tr.customer_code = cs.customer_code
									group by cs.customer_name
									order by revenue desc)
select *from sum_per_customer
limit 5;


--To see the total Revenue by month for a specific year 
with sum_per_year_and_customer as (select dt.year, dt.month_name, cs.customer_name,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  customers cs
									on tr.customer_code = cs.customer_code
									inner join date dt
									on tr.order_date = dt.order_date
									group by cs.customer_name,dt.year, dt.month_name
									order by revenue desc)
select *from sum_per_year_and_customer
where year = 2017;


--To see top 5 Customer which made the most revenue for a speicific year.
with sum_per_year_and_customer as (select dt.year, cs.customer_name,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  customers cs
									on tr.customer_code = cs.customer_code
									inner join date dt
									on tr.order_date = dt.order_date
									group by cs.customer_name,dt.year
									order by revenue desc)
select *from sum_per_year_and_customer
where year = 2017
limit 5;


--To see top 5 Customer which made the most revenue for a speicific year and year of the month.
with sum_per_year_and_customer as (select dt.year,dt.month_name, cs.customer_name,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  customers cs
									on tr.customer_code = cs.customer_code
									inner join date dt
									on tr.order_date = dt.order_date
									group by cs.customer_name,dt.year, dt.month_name 
									order by revenue desc)
select *from sum_per_year_and_customer
where year = 2017 and month_name ilike 'october'
limit 5;

--To see top 5 Products which made the most revenue.

with sum_per_year_and_products as (select  pd.product_code, sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  products pd
									on tr.product_code = pd.product_code
									group by  pd.product_code
									order by revenue desc)
select *from sum_per_year_and_products
limit 5;


--To see top 5 Products which made the most revenue by a specific year and month.

with sum_per_year_and_products as (select dt.year,dt.month_name,pd.product_code,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  products pd
									on tr.product_code= pd.product_code
									inner join date dt
									on tr.order_date = dt.order_date
									group by pd.product_code,dt.year, dt.month_name 
									order by revenue desc)
select *from sum_per_year_and_products
where year = 2017 and month_name ilike 'october'
limit 5;

--To see top 5 Products which made the most revenue by a specific year.

with sum_per_year_and_products as (select dt.year,pd.product_code,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join  products pd
									on tr.product_code= pd.product_code
									inner join date dt
									on tr.order_date = dt.order_date
									group by pd.product_code,dt.year
									order by revenue desc)
select *from sum_per_year_and_products
where year = 2017 
limit 5;

--To see Revenues for a specific year by month.

with sum_per_year_and_products as (select dt.year,dt.month_name,sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join date dt
									on tr.order_date = dt.order_date
									group by dt.year, dt.month_name 
									order by revenue desc)
select *from sum_per_year_and_products
where year = 2017;



--To see Revenues for each zone for a specific year.

with sum_per_year_and_products as (select dt.year,mr.zone, sum(tr.sales_amount) as revenue, sum(tr.sales_qty) as total_sales_quantity
									from transactions1 tr
									inner join date dt
									on tr.order_date = dt.order_date
									inner join markets mr
									on tr.market_code = mr.market_code
									group by dt.year,mr.zone 
									order by revenue desc)
select *from sum_per_year_and_products
where year = 2017;






