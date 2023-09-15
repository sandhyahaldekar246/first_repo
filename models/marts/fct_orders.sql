with cust as(
    select * from {{ source("staging","customers") }}
),
ord as(
    select * from {{source("staging","orders") }}
),
cust_ord as(
    select user_id as customer_id,count(id::int) as number_of_orders from ord group by ord.user_id
),
final as(
select customer_id,concat(cust.last_name,cust.first_name) as name, number_of_orders from cust_ord left join cust on
cust.id=cust_ord.customer_id
     )
select *from final