--select * from [dbo].[products]
--select * from [dbo].[regions]
--select * from [dbo].[sales]
--select * from [dbo].[salespeople]

WITH RankedSales AS (
    SELECT
        s.product_id,
        p.price,
        s.quantity,
        p.price * s.quantity AS total_sale_amount,
        ROW_NUMBER() OVER (PARTITION BY s.product_id ORDER BY p.price * s.quantity DESC) AS sale_rank
    FROM
        [dbo].[sales] s
    JOIN [dbo].[products] p ON s.product_id = p.product_id
)
SELECT
    product_id,
    price,
    quantity,
    total_sale_amount,
    sale_rank
FROM
    RankedSales
WHERE
    sale_rank <= 10;


	WITH RankedSales AS (
    SELECT
        s.product_id,
        p.price,
        s.quantity,
        p.price * s.quantity AS total_sale_amount,
        RANK() OVER (PARTITION BY s.product_id ORDER BY p.price * s.quantity DESC) AS sale_rank
    FROM
        [dbo].[sales] s
    JOIN [dbo].[products] p ON s.product_id = p.product_id
)
SELECT
    product_id,
    price,
    quantity,
    total_sale_amount,
    sale_rank
FROM
    RankedSales
WHERE
    sale_rank <= 10;


SELECT
    s.salesperson_id,
    sp.salesperson_id,
    SUM(p.price * s.quantity) AS total_sales_amount
FROM
    [dbo].[sales] s
JOIN [dbo].[products] p ON s.product_id = p.product_id
JOIN [dbo].[salespeople] sp ON s.salesperson_id = sp.salesperson_id
GROUP BY
    s.salesperson_id,
    sp.salesperson_id
ORDER BY
    total_sales_amount DESC; 
