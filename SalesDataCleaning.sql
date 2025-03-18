--First, I started with Data Cleaning 


select *from transactions;

-- I filtered out any sales amount which are zero or less and deleted them because, They are not helpful for insights. 
select *from transactions
where not sales_amount > 0;

delete from transactions
where sales_amount = -1 or sales_amount = 0;

--I got rid of the '\r' from the entries of the currency column.
update transactions 
set currency = trim( trailing '\r' from currency );

-------------------------------------------------------------------------------------------------------------------------------------------------------

--I wanted to see how many duplicate values there are in the table.
with duplicate_cte as (
	select *, 
	row_number() over(partition by  product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency) as row_num
	from transactions
)
select * from cte_filter
where row_num > 1;

--Create a new table out of the duplicate_cte cause, I can't directly delete.
with duplicate_cte as (
	select *, 
	row_number() over(partition by  product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency) as row_num
	from transactions
)
select * into transactions1 
from duplicate_cte;

--Now, Delete duplicate values from transactions1.
delete from transactions1 
where row_num > 1;


select *from transactions1;

-------------------------------------------------------------------------------------------------------------------------------------------------
--Now, I can check for any mistakes or unappropriate data in the columns
-- 338 unique Products sold 
select distinct product_code
from transactions1
order by product_code asc;

--I detected that only 279 product which are sold that have had the information on the Products table. which means 59 Products information are missing. 
select pd.product_code, pd.product_type, tr.product_code, tr.customer_code, tr.market_code, tr.order_date, tr.sales_qty, tr.sales_amount from 
products pd inner join transactions1 as tr 
on pd.product_code = tr.product_code;

--I wanted to check if those unknown products are really sold by checking sales_qty and sales_amount.
select * from transactions1 
where cast(right(product_code, 3) as int) > 279
order by product_code;

select * from transactions1 
where cast(right(product_code, 3) as int) > 279 and ((sales_qty = 0 or sales_qty is null) and (sales_amount = 0 or sales_amount is null))
order by product_code;

--I will delete those records because, I don't know which Producst are sold.
delete from transactions1
where cast(right(product_code, 3) as int) > 279;


--This Column is fine.
select distinct customer_code
from transactions1
order by customer_code asc;

--There are 15 unique Markets but in the Markets table there are 17 Markets definetely, two markets which don't have any transactions.
select distinct market_code
from transactions1
order by  market_code asc;

select *from 
markets mk left join transactions1 tr 
on mk.market_code = tr.market_code;

--I will delete them in the Markets Table
delete from markets 
where markets_name in ('Paris', 'New York');

--Deleting the row_num column
alter table transactions1 
drop row_num;
select *from transactions1;

--------------------------------------------------------------------------------
--There are 1126 records 
select distinct order_date from transactions1;

--There are only 801 unique order_date in the transactions table 
select distinct tr.order_date
from date dt inner join transactions1 tr 
on dt.order_date = tr.order_date;

--To see those date entries without transactions
select *
from date dt left join transactions1 tr 
on dt.order_date = tr.order_date;

--I deleted those unmatched date entries in date table.
delete from date dt
where not exists (
    select 1 from transactions1 tr 
    where tr.order_date = dt.order_date
);


--------------------------------------------------------------------------

select *from transactions1;

--I have USD entries need to be converted to INR
select sales_amount, currency from transactions1
where currency ilike 'usd';
 
update transactions1 
set sales_amount = sales_amount*75,
     currency = 'INR'
where currency ilike 'usd';

select *from transactions1;

----------------------------------------------------------------------------------------------------------------------------------------------------------




