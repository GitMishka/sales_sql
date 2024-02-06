select * from [dbo].[products_data]
select * from [dbo].[sales_data]
select * from [dbo].[salesmen_data]

WITH cte1 AS (
    SELECT 
        salesman,
        productid,
        sales * price as sum,
        RANK() OVER (PARTITION BY (sales * price) ORDER BY productid DESC) AS Rank
    FROM [dbo].[sales_data] 
)
SELECT * FROM cte1 order by sum desc
WHERE Rank = 1;


select * from cte1

with cte1 as (
SELECT
  productid,
  salesman,
  sales,
  price,
  datetime,
  price * sales AS total_sales_value,
  RANK() OVER (ORDER BY price * sales DESC) AS sales_rank
FROM
  [dbo].[sales_data])

  select * from cte1 where sales_rank = 1



with cte1 as (
SELECT
  productid,
   salesman
  ,price * sales total_sum,
  RANK() OVER (PARTITION BY productid ORDER BY price * sales DESC) AS sales_value_rank
FROM


  [dbo].[sales_data] )

  select * from cte1 where sales_value_rank <3


  SELECT
  datetime,
  productid,
  sales,
  SUM(sales) OVER (PARTITION BY productid ORDER BY datetime) AS cumulative_sales
FROM [dbo].[sales_data]
ORDER BY productid, datetime;


WITH ranked_salespeople AS (
  SELECT
    salesman,
    SUM(price * sales) AS total_sales_value,
    RANK() OVER (ORDER BY SUM(price * sales) DESC) AS rank
  FROM [dbo].[sales_data]
  GROUP BY salesman
)
SELECT *
FROM ranked_salespeople
WHERE rank <= 5;


SELECT
  DATEPART(YEAR, datetime) AS year,
  DATEPART(QUARTER, datetime) AS quarter,
  SUM(sales) AS total_sales,
  SUM(price * sales) AS total_sales_value
FROM [dbo].[sales_data]
GROUP BY DATEPART(YEAR, datetime), DATEPART(QUARTER, datetime)
ORDER BY year, quarter;

