{{
    config(materialized="view")
}}
with customers as(
    select * from {{ref("cust_stg")}}
    ),
orders as(
    select * from {{ref("order_stg")}}
),
customers_orders as(
    select customer_id, min(order_id) as first_order, max(order_id) as last_order,
     max(order_date) as most_recent_order_date, count(order_id) as total_orders
    from orders group by 1
),
final as(
    select 
    customers.customer_id,
    concat(customers.last_name,customers.first_name) as customer_name,
    customers_orders.first_order,
    customers_orders.last_order,
    customers_orders.most_recent_order_date, 
    coalesce(customers_orders.total_orders,0) as number_of_orders
    from customers
    left join customers_orders using(customer_id)
)
select * from final