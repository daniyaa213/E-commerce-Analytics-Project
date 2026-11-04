select * from 
ecommerce_delivery_analytics_new edan


/*Question 1: What is the total number of orders?*/
SELECT 
COUNT(*) AS total_orders
FROM ecommerce_delivery_analytics_new edan 
/*Purpose: To determine the total number of orders in the dataset*/

/*Question 2: Which platform receives the highest number of orders?*/
SELECT
    Platform,
    COUNT(*) AS total_orders
FROM ecommerce_delivery_analytics_new edan 
GROUP BY Platform
ORDER BY total_orders desc
/*Purpose: To compare the number of orders received by each platform*/

/*Question 3: Which platform has the highest average delivery time?*/
SELECT
    Platform,
    ROUND(AVG(`Delivery Time (Minutes)`), 2)
        AS average_delivery_time
FROM ecommerce_delivery_analytics_new edan 
GROUP BY Platform
ORDER BY average_delivery_time desc
/*Purpose: To identify which platform takes the longest time to deliver orders on average.*/

/*Question 4: How many orders were delayed?*/
SELECT
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN `Delivery Delay` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS delayed_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN `Delivery Delay` = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS delay_percentage
FROM ecommerce_delivery_analytics_new edan 
/*Purpose: To calculate the total number and percentage of delayed orders.*/

/*Question 5: Which platform has the highest delivery delay rate?*/
SELECT
    Platform,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN `Delivery Delay` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS delayed_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN `Delivery Delay` = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS delay_percentage
FROM ecommerce_delivery_analytics_new edan 
GROUP BY Platform
ORDER BY delay_percentage desc
/*Purpose: To compare delivery delay rates across platforms and identify areas that may need improvement.*/

/*Question 6: Which product category generates the highest revenue?*/
SELECT
    `Product Category`,
    SUM(`Order Value (INR)`) AS total_revenue
FROM ecommerce_delivery_analytics_new edan 
GROUP BY `Product Category`
ORDER BY total_revenue desc
/*Purpose: To identify the product categories contributing the most to total order value.*/
/*Note: Total order value is not the same as business profit.*/

/*Question 7: Which platform has the highest average customer rating?*/
SELECT
    Platform,
    ROUND(AVG(`Service Rating`), 2) AS average_rating,
    COUNT(*) AS total_ratings
FROM ecommerce_delivery_analytics_new edan 
GROUP BY Platform
ORDER BY average_rating DESC
/*Purpose: To compare customer satisfaction across platforms.*/

/*Question 8: What percentage of orders have refund requests?*/
SELECT
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN `Refund Requested` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS refund_requests,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN `Refund Requested` = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS refund_percentage
FROM ecommerce_delivery_analytics_new edan 
/*Purpose: To measure the frequency of refund requests.*/

/*Question 9: Are delayed orders more likely to have refund requests?*/
SELECT
    `Delivery Delay`,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN `Refund Requested` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS refund_requests,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN `Refund Requested` = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS refund_rate
FROM ecommerce_delivery_analytics_new edan 
GROUP BY `Delivery Delay`
/*Purpose: To investigate the relationship between delivery delays and refund requests.*/

/*Question 10: What are the most common customer feedback messages?*/
SELECT
    `Customer Feedback`,
    COUNT(*) AS feedback_count
FROM ecommerce_delivery_analytics_new edan 
GROUP BY `Customer Feedback`
ORDER BY feedback_count DESC
LIMIT 10
/*Purpose: To identify frequently reported customer experiences and potential service issues.*/

/*Question 11: Which customers place the highest number of orders?*/
SELECT
    `Customer ID`,
    COUNT(*) AS total_orders,
    SUM(`Order Value (INR)`) AS total_spending
FROM ecommerce_delivery_analytics_new edan 
GROUP BY `Customer ID`
ORDER BY total_orders DESC
LIMIT 10
/*Purpose: To identify customers with the highest order frequency and recorded spending.*/

/* Question 12: Are there any duplicate Order IDs?*/
SELECT
    `Order ID`,
    COUNT(*) AS id_count
FROM ecommerce_delivery_analytics_new edan 
GROUP BY `Order ID`
HAVING COUNT(*) > 1
/*Purpose: To identify duplicate order identifiers that may require investigation.*/

