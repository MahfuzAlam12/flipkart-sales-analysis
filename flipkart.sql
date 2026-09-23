CREATE TABLE FLIPKART (
	ORDER_ID varchar,
	PRODUCT_NAME VARCHAR(50),
	CATEGORY VARCHAR(50),
	PRICE_INR NUMERIC(10, 2),
	QUANTITY_SOLD INT,
	TOTAL_SALES_INR NUMERIC(10, 2),
	ORDER_DATE DATE,
	PAYMENT_METHOD VARCHAR(50),
	CUSTOMER_RATING NUMERIC(10, 2),
	MONTH VARCHAR(50),
	YEAR INT,
	PROFIT_INR NUMERIC(10, 2),
	DISCOUNT NUMERIC(10, 2),
	CUSTOMER_SEGMENT VARCHAR(60),
	REGION VARCHAR(50)
);

select * from flipkart;


/*PHASE 1 — SQL Analysis

Pehle SQL mein dataset analyse karo.

1. Overall Business Performance

Management ko ye metrics chahiye:

Total Orders
Total Quantity Sold
Total Sales
Total Profit
Average Order Value
Profit Margin %
Business question:

"Overall business ki sales aur profitability kaisi hai?"*/
create view total_order as
select count(order_id) as total_order
from flipkart

select * from total_order --total order 1000

--Total Quantity Sold
create view Total_Quantity_Sold as
select sum(quantity_sold) as total_quantity_sold 
from flipkart;

select * from Total_Quantity_Sold -- total quantity sold 3097

--Total Sales
create view Total_Sales as
select sum(price_inr * quantity_sold) as total_sales
from flipkart;

select * from Total_Sales; --total sales 75213112.74

--Total Profit
create view total_profit as 
select sum(profit_inr) as total_profit
from flipkart;

select * from total_profit; -- total profit 15042622.53

--Average Order Value
create view average_order_value as 
select sum(price_inr * quantity_sold) / count(order_id ) as average_order_value
from flipkart;

select * from average_order_value ; -- average_order_value 75213

--Profit Margin %
create view profit_margin as 
select sum(price_inr * quantity_sold) / sum(profit_inr) as profit_margin 
from flipkart;

select * from profit_margin; -- profit_margin 5.00 %


/*2. Category Performance

Har category ke liye:

Total Sales
Total Profit
Quantity Sold
Number of Orders
Average Discount
Profit Margin %
Business question:

"Kaunsi category revenue generate kar rahi hai aur kaunsi category profit generate kar rahi hai?"*/

-- category-wise Total Sales
create view category_wise_total_sales as
select category, sum(price_inr * quantity_sold ) as total_sales
from flipkart 
group by category;

select * from category_wise_total_sales; /*  category_wise_total_profit
                                            "Electronics"	    17307173.07
                                            "Home & Kitchen"	13325209.11
                                            "Clothing"	        15114386.86
                                            "Books"	            14785759.65
                                            "Beauty"	        14680584.05*/
--category-wise Total profit
create view category_wise_Total_profits as
select category, sum(profit_inr) as total_profit
from flipkart 
group by category;

select * from category_wise_Total_profits; /*category_wise_Total_profits
                                             "Electronics"	3461434.61
                                             "Home & Kitchen"	2665041.80
                                             "Clothing"	3022877.41
                                             "Books"	2957151.89
                                              "Beauty"	2936116.82*/


--Quantity Sold
create view category_wise_total_quantity_sold as
select category, sum(quantity_sold) as total_quantity_sold 
from flipkart 
group by category ;

select * from category_wise_total_quantity_sold ;
/*category_wise_total_quantity_sold 
"Electronics"	    673
"Home & Kitchen"	579
"Clothing"	        609
"Books"	            653
"Beauty"	        583*/

--Number of Orders
create view category_wise_no_of_orders as
select category, count(order_id) as no_of_orders 
from flipkart 
group by category;

select *  from category_wise_no_of_orders; /*
"Electronics"	    217
"Home & Kitchen"	193
"Clothing"	        189
"Books"	            209
"Beauty"	        192 */


--Average Discount
create view category_wise_avgerage_discount as
select category, avg(discount) as avg_discount 
from flipkart 
group by category ;

select * from category_wise_avgerage_discount ; /*
"Electronics"	    17.3778801843317972
"Home & Kitchen"	16.7979274611398964
"Clothing"	        18.4391534391534392
"Books"	            18.3492822966507177
"Beauty"	        17.5312500000000000*/

--Profit Margin %
create view category_wise_profit_margin as
select category , sum(price_inr * quantity_sold) / sum(profit_inr) as profit_margin
from flipkart 
group by category ;

select * from category_wise_profit_margin; /*
"Electronics"	    5.0000000057779511
"Home & Kitchen"	5.0000000412751500
"Clothing"	        4.9999999371459791
"Books"	            5.0000000676326437
"Beauty"	        4.9999999829707048*/

/*3. Product Performance

Management jaana chahta hai:

"Humare top-performing aur weak products kaunse hain?"

Find:

Top 10 products by Sales
Top 10 products by Profit
Bottom 10 products by Profit
Quantity Sold*/

--Top 10 products by Sales

create view top_10_product_by_sales as
select product_name,sum(price_inr*quantity_sold ) as total_sales
from flipkart 
group by product_name
order by total_sales desc
limit 10;

select * from top_10_product_by_sales; /*
"Educational Book"	4522055.35
"Laptop"	        4132783.72
"Table Lamp"	    3986691.68
"Headphones"	    3722765.27
"Jeans"          	3685259.60
"Smartwatch"	    3680177.80
"Face Cream"	    3646816.97
"Perfume"	        3266905.75
"Fiction Novel"     3172999.91
"Jacket"	        3161049.05*/

--Top 10 products by Profit

create view top_10_products_by_profit as
select product_name,sum(profit_inr) as total_profit 
from flipkart 
group by product_name
order by total_profit desc
limit 10 ;

select * from top_10_products_by_profit; /*
"Educational Book"	904411.02
"Laptop"	        826556.75
"Table Lamp"	    797338.36
"Headphones"	    744553.06
"Jeans"    	        737051.95
"Smartwatch"	    736035.55
"Face Cream"	    729363.40
"Perfume"	        653381.13
"Fiction Novel"     634599.98
"Jacket"	        632209.81*/

--Bottom 10 products by Profit

create view bottom_10_product_profit as
select product_name,sum(profit_inr) as total_profit 
from flipkart 
group by product_name
order by total_profit asc
limit 10 ;

select * from bottom_10_product_profit; /* 
"Bedsheet"	    376768.65
"Comic Book"	387692.02
"Mixer Grinder"	459435.31
"Shampoo"	    483504.33
"Dress"   	    495586.00
"Cookware Set"	498110.28
"Hair Dryer"	501026.13
"Cookbook"	    502835.84
"Self-Help Book"	527613.03
"Sofa Cover"	    533389.20*/


--bottom 10 product by Quantity Sold

create view bottom_10_product_by_quantity_sold as
select product_name, sum(quantity_sold) as total_quantity_sold 
from flipkart 
group by product_name
order by total_quantity_sold asc 
limit 10

select * from bottom_10_product_by_quantity_sold; /*
"Bedsheet"	       89
"Shampoo"	       92
"Cookbook"	       92
"Dress"	           100
"Hair Dryer"	   108
"Mixer Grinder"	   111
"Self-Help Book"   115
"Sofa Cover"	   118
"Cookware Set"	   120
"Comic Book"	   120*/

/*PHASE 2 — Discount Analysis

Ye client ke liye important hai.

Hum discount dete hain taaki sales increase ho.

Lekin question:

"Kya higher discount actually profitable hai?"

SQL mein discount ko groups mein analyse karo:

0–10%
11–20%
21–30%
31%+

Har group ke liye:

Orders
Sales
Profit
Profit Margin
Quantity Sold
Business question:

"Kya high discount wale orders mein profit margin kam ho raha hai?"*/
create view discount_analysis as 
select 
     case 
	     when discount <= 10 then '0-10'
		 when discount <= 20 then '11-20'
		 when discount <= 30 then '21-30'
	     else '31'
		 end as discount_group,

		 
		 count(order_id ) as orders,
		 sum(price_inr*quantity_sold) as sales,
		 sum(profit_inr) as profit,
		 sum(price_inr * quantity_sold) / sum(profit_inr) as profit_margin,
		 sum(quantity_sold) as quantity_sold

		 from flipkart 
		 group by
		         case 
	     when discount <= 10 then '0-10'
		 when discount <= 20 then '11-20'
		 when discount <= 30 then '21-30'
	     else '31'
		 end
		 order by discount_group;

select * from discount_analysis

/*PHASE 3 — Regional Analysis

Har Region ke liye:

Orders
Sales
Profit
Profit Margin
Quantity Sold
Average Rating

Business question:

"Kaunsa region strongest hai aur kis region mein improvement ki requirement hai?"

Regions ko North / South / East / West ke basis par analyse karo.*/

create view region_analysis as
select region, count(order_id) as total_order,
               sum(price_inr*quantity_sold) as total_sales,
			   sum(profit_inr) as total_profit,
			   sum(price_inr * quantity_sold) / sum(profit_inr) as profit_margin,
			   sum(quantity_sold) as total_quantity_sold,
			   avg(customer_rating) as average_rating 
			   from flipkart 
			   group by region ;

select * from region_analysis;


/*PHASE 4 — Customer Segment

Dataset mein Customer Segment hai.

Analyse:

Sales by Customer Segment
Profit by Customer Segment
Orders by Customer Segment
Average Order Value
Average Discount

Business question:

"Online vs Wholesale customers mein business performance ka difference kya hai?"*/
create view customer_segment_analysis as
select customer_segment,
                      count(order_id) as order_segment,
               sum(price_inr*quantity_sold) as sales_segment,
			   sum(profit_inr) as profit_segment,
			   sum(price_inr*quantity_sold)/ count(order_id) as average_order_value_segment,
			   avg(discount) as average_discount_segment 
			   from flipkart 
			   group by customer_segment ;

select * from customer_segment_analysis;			   


/*PHASE 5 — Payment Method

Management jaana chahta hai:

"Customers ka payment behaviour kya hai?"

Analyse:

Orders by Payment Method
Sales by Payment Method
Profit by Payment Method
Average Order Value*/
create view payment_method_analysis as
select  payment_method, 
                      count(order_id) as total_order,
               sum(price_inr*quantity_sold) as total_sales,
			   sum(profit_inr) as total_profit,
			   sum(price_inr*quantity_sold)/ count(order_id) as average_order_value
			   from flipkart 
			   group by payment_method ;

select * from payment_method_analysis;

/*PHASE 7 — Customer Rating

Analyse:

Average Rating by Category
Average Rating by Region
Average Rating by Customer Segment
Rating vs Sales
Rating vs Profit

Business question:

"Customer satisfaction aur business performance ke beech koi noticeable relationship hai?"

Yahan correlation claim directly mat karna sirf chart dekhkar. Pehle data ko properly analyse karna.*/

--Average Rating by Category
create view average_rating_by_category as
select category, avg(customer_rating) as avg_rating
from flipkart
group by category
order by avg_rating;

select * from average_rating_by_category;

--Average Rating by Region
create view average_rating_by_region as
select region, avg(customer_rating) as avg_rating
from flipkart
group by region 
order by avg_rating;

select * from average_rating_by_region ;

--Average Rating by Customer Segment

select customer_segment, avg(customer_rating) as avg_rating
from flipkart
group by customer_segment 
order by avg_rating;

--Rating vs Sales
SELECT 
    customer_rating,
    SUM(price_inr * quantity_sold) AS total_sales
FROM flipkart
GROUP BY customer_rating
ORDER BY customer_rating;
                     

--Rating vs Profit

SELECT 
    customer_rating,
    SUM(profit_inr) AS total_profit
FROM flipkart
GROUP BY customer_rating
ORDER BY customer_rating;


/*PHASE 6 — Time Analysis

Order Date ke basis par:

Monthly:
Monthly Sales
Monthly Profit
Monthly Orders
Yearly:
Sales by Year
Profit by Year
Orders by Year

Business question:

"Business kab grow ya decline hua?"

Aur agar kisi month mein sales high ho lekin profit low ho, reason investigate karna hai.*/

--Monthly Sales
select month,sum(price_inr*quantity_sold) as monthly_sale
from flipkart 
group by month
order by month asc;

--Monthly Profit
select month,sum(profit_inr) as monthly_profit
from flipkart 
group by month;

--Monthly Orders

select month,count(order_id) as monthly_order
from flipkart
group by month;

--Sales by Year

select year,sum(price_inr*quantity_sold) as annual_sale
from flipkart 
group by year;

--Profit by Year

select year,sum(profit_inr) as annual_profit
from flipkart 
group by year;

--Orders by Year

select year,count(order_id) as annual_order
from flipkart
group by year;
