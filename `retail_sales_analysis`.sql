-- CREATE TABLE retail1 (
-- --    --  -- transactions_id INT PRIMARY KEY,
-- -- --     sale_date DATE,
-- -- --     sale_time TIME,
-- -- --     customer_id INT,
-- -- --     gender VARCHAR(15),
-- -- --     age INT,
--     category VARCHAR(15),
--      quantiy INT,
--    price_per_unit FLOAT,
--     cogs FLOAT,
--     total_sale FLOAT
-- -- -- );

ALTER TABLE retail1
RENAME COLUMN cogs to purchase_cost;

-- how many rows we have
SELECT 
    *
FROM
    retail1;
    
    
    -- how many sales we have
		SELECT 
    COUNT(*) AS total_sales
FROM
    retail1;


-- how many unique customers we have
SELECT 
    COUNT(DISTINCT customer_id) AS unique_customer
FROM
    retail1;
    
    -- how many catagories we have
SELECT 
    COUNT(DISTINCT category) AS category
FROM
    retail1;
    
    
    -- Q1 retrieve all columns where sales made in 2022-11-05
SELECT 
    *
FROM
    retail1
WHERE
    sale_date = '2022-11-05';
    
    
-- retreive all transaction where sum of quantity in the clothing category is equal 4 in the month of Nov-2022
SELECT 
    *
FROM
    retail1
WHERE
    category = 'clothing'
        AND sale_date LIKE '2022-11-%'
        AND quantiy = 4;

-- calculate the total sales for each category
SELECT 
    SUM(total_sale), category
FROM
    retail1
GROUP BY category;


-- find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
    COUNT(transactions_id), gender, category
FROM
    retail1
GROUP BY gender , category;


-- average age of customers who buy from beauty category

SELECT 
    AVG(age)
FROM
    retail1
WHERE
    category = 'beauty';

-- find all transactions where total sales is greater than 1000

SELECT 
    *
FROM
    retail1
WHERE
    total_sale > 1000;

-- calculate the average sale for each month, find out the best selling month in each year
select * from (select avg(total_sale),year(sale_date),month(sale_date),rank() over(partition by year(sale_date) order by avg(total_sale) desc) as Rank1  from retail1 group by year(sale_date),month(sale_date)) as t1 where t1.Rank1 = 1;

-- find the top 5 customers based on the highest total sale

SELECT 
    customer_id, SUM(total_sale)
FROM
    retail1
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;


-- find the number of unique customers who purchased items in from each category

SELECT 
    COUNT(DISTINCT customer_id), category
FROM
    retail1
GROUP BY category;

-- create each shift and number of orders(for example morning<=12 , afternoon between 12 and 17 , evening > 17)

SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
        ELSE 'evening'
    END AS shift,
    COUNT(transactions_id)
FROM
    retail1
GROUP BY shift;
