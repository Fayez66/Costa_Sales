create database costaSales;
use costaSales;

delete from [costa Sales]
where transaction_id is null or transaction_id = '';

alter table [costa Sales]
alter column transaction_date date ;

update [costa Sales]
set transaction_date = CONVERT (date ,transaction_date ,103);

select * from [costa Sales];

/*extea spaces befor & after*/
update [costa Sales]
set transaction_id = ltrim(rtrim(transaction_id)); 


UPDATE [costa Sales]
SET product_type = 'Unknown' WHERE product_type IS NULL;
/*set product_type = coalesce (product_type ,'Unknown' )*/

exec sp_rename'costa Sales.[transaction_id]', 'ID','column';

--analysis

select round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]


alter table [costa Sales]
add totalsales as (unit_price * transaction_qty);

select round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]
where month(transaction_date) = 5;

select round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]
where transaction_date = '2023-1-18';

select count(ID) as totalorders
from [costa Sales]

select sum([transaction_qty]) as totalQuatity
from [costa Sales]

select sum([transaction_qty]) as totalQuatity,
count(ID) as totalorders,
round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]

--sales by store location
select [store_location] ,round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]
group by [store_location]
order by totalsales desc;

--sales by product category
select [product_category] ,round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]
group by [product_category]
order by totalsales desc;

--sales by product top 10
select top 10 [product_type] ,round(SUM(unit_price * transaction_qty),2) as totalsales
from [costa Sales]
group by [product_type]
order by totalsales desc;




--total sales weekends and weekdays
select * from [costa Sales];


SELECT 
    CASE 
        WHEN DATEPART(WEEKDAY, transaction_date) IN (1, 7) THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_type, 
    SUM(totalsales) AS total_sales 
FROM [costa Sales] 
GROUP BY 
    CASE 
        WHEN DATEPART(WEEKDAY, transaction_date) IN (1, 7) THEN 'Weekend' 
        ELSE 'Weekday' 
    END;

--OR
SELECT 
    SUM(CASE WHEN DATEPART(WEEKDAY, transaction_date) IN (1, 7) THEN totalsales ELSE 0 END)
	AS weekend_sales,

    SUM(CASE WHEN DATEPART(WEEKDAY, transaction_date) NOT IN (1, 7) THEN totalsales ELSE 0 END)
	AS weekday_sales
FROM [costa Sales];