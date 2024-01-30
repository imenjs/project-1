
/* 1. Select everything from the sales table and create a new column called 
   "sales_category" with case conditions to categorise qty:
   
		qty >= 50 high sales
		20 <= qty < 50 medium sales
		qty < 20 low sales
*/
use publications;

Select * ,
case
 when qty>= 50 then 'high sales'
 when qty between 20 and 50  then 'medium sales'
 else ' low sales'
 end as sales_category
from sales ;

/* 2. Given your three sales categories (high, medium, and low), 
   calculate the total number of books sold in each category. 
*/
Select sum(qty) as sale,
case
 when qty>= 50 then 'high sales'
 when qty between 20 and 50  then 'medium sales'
 else ' low sales'
 end as sales_category
from sales 
group by sales_category
order by sale ;


/* 3. Adding to your answer from the previous questions: output only those 
   sales categories that have a SUM(qty) greater than 100, and order them in 
   descending order */
   
   Select count(*) as sale, sum(qty),
case
 when qty>= 50 then 'high sales'
 when qty between 20 and 50  then 'medium sales'
 else ' low sales'
 end as sales_category
from sales 
group by sales_category having sum(qty) >100
order by sale ;

/* 4. Find out the average book price, per publisher, for the following book 
    types and price categories:
		book types: business, traditional cook and psychology
		price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
        
    - When displaying the average prices, use ROUND() to hide decimals. */
    
    Select  pub_name,
    case 
    when price <= 5 then 'super low'
    when price <=10 then 'low'
    when price <= 15 then 'medium'
    else 'high' 
     end as price_categories , round(avg(price)) as 'avg_price' 
     from titles left join publishers 
     on titles.pub_id = publishers.pub_id
    
     where type IN ('business' , 'trad_cook', 'psychology')
     group by titles.pub_id, price_categories
     order by avg_price;
     
     