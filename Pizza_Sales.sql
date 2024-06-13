create database pizzasales;
create table orders (
order_id int not null,
orer_date date not null,
order_time time not null,
primary key (order_id) );

create table order_details(
order_detail_id int not null,
order_id varchar (50),
pizza_id text not null,
quantity int not null,
primary key (order_detail_id) );

--  Q1.  Retrieve the total number of orders placed ??
select count(order_id) as total_orders from orders;

--  Q2. Calculate the total revenue generated from pizza sales ??
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
    

--  Q3.  Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;



--  Q4.  Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details.order_detail_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;



-- Q5: List the top 5 most ordered pizza types along with their quantities ??
select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5 ;




--   Intermediate Questions  :
-- Q1 :   Join the necessary tables to find the total quantity of each pizza category ordered ???
select pizza_types.category,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc ;


--  q2 :  Determine the distribution of orders by hour of the day  ??
select hour(order_time), count(order_id) from orders
group by hour(order_time);



--  Q3 : Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category 


--  Q4 : Group the order by date and calculate the avg number of pizzas ordered per day ??
select * from orders;
alter table orders
change column orer_date order_date time;
select * from orders;

SELECT 
    ROUND(AVG(quantity), 0)
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;


--  Q5 : Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;













