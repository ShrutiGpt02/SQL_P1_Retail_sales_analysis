#CREATE DATABASE 
create database sql_project_p1;

#CHOOSING WHICH DATABASE TO USE 
use sql_project_p1;


# CREATE TABLE  
create table Retail_sales 
(transactions_id int primary key, 
sale_date date, 
sale_time time, 
customer_id	int,
gender varchar(10),
age	int,
category varchar(15),	
quantity int,	
price_per_unit float,
cogs float,
total_sale float);

#SHOW DATA 
SELECT *FROM RETAIL_SALES 
LIMIT 10;

# SEE THE TOTAL NO OF RECORDS 
Select count(*) from retail_sales;

## DATA CLEANING
#FETCH THE NULL VALUES 
select * from retail_sales where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

# DELETE THE NULL VALUES 
delete from retail_sales where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

## DATA EXPLORATION

# HOW MANY SALES WE HAVE 
select count(*) from retail_sales;

# HOW MANY CUSTOMERS WE HAVE 
select count(customer_id) from retail_sales;
# HOW MANY UNIQUE CUSTOMERS WE HAVE 
select count(distinct (customer_id)) from retail_sales;

# HOW MANY  UNIQUE CATEGORIES WE HAVE 
select count( distinct(category)) from retail_sales;

# NAME THE UNIQUE CATEGORIES 
select distinct category from retail_sales;

## DATA ANALYSIS  AND BUSINESS KEY PROBLEMS & ANSWERS 

#RETRIEVE ALL COLUMNS FOR SALES ON "2022-11-05"
select *from retail_sales where sale_date = "2022-11-05";

#RETRIEVE ALL COLUMNS WHERE CATEFORY IS CLOTHING AND THE QUANTITY IS MORETHAN 04 IN THE MONTH OF NOV- 2022
select * from retail_sales
where category = "clothing"
and
date_format(sale_date,'%Y-%m')="2022-11"
and 
quantity >=4;

# CALCULATE THE TOTAL SALES FOR EACH CATEGORY 
select category,sum(total_sale) from retail_sales
group by category;

CALCULATE THE TOTAL ORDERS FOR EACH  CATEGORY
select category, COUNT(*) AS total_orders from retail_sales
group by category;

# AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE BEAUTY CATEGORY 
select round(avg(age)) as avg_age from retail_sales
where category = "beauty";

#TRANSACTION WHERE TOTAL SALE SIS GREATER THAN 1000
select * from retail_sales
where total_sale > 1000;

# TOTAL NO OF TRANSACTIONS (TRANSC_ID) MADE BY GENDER IN EACH CATEGORY 
select category, gender, count(transactions_id) from retail_sales
group by category, gender
order by category;

#AVERAGE SALE FOR EACH MONTH, FIND OUT BEST SELLING MONTH IN EACH YEAR 
select year(sale_date)as year,
month(sale_date)as month ,
round(avg(total_sale)) as total_sales,
rank() over( partition by year(sale_date)
order by round(avg(total_sale))desc)
from retail_sales
group by 1,2 
order by 1, 3 desc;

#TOP 5 CUSTOMERS BASEDD ON HIGHEST TOTAL SALES 
select customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1 
order by 2 desc
limit 5; 

#NO OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY 
select category, 
count(distinct customer_id) as unique_customers
from retail_sales
group by category; 

# CREATE SHIFTS AND NO OF ORDERS FOR EACH SHIFTS (EXAMPLE- MORNING<=12, AFTERNOON BETWEEN 12 TO 17, EVENING> 17)
select case
when  hour(sale_time)<= 12 then 'morning'  
when  hour(sale_time) between 12 and 17 then 'afternoon' 
else 'evening'
end as shift, 
count(transactions_id)
from retail_sales
group by 1 ;

commit;

---# END OF PROJECT --- 
