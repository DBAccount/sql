
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

-- select * from customer_orders;
insert into customer_orders values(1,100,'2022-01-01' ,2000);
insert into customer_orders values(2,200,'2022-01-01' ,2500);
insert into customer_orders values(3,300,'2022-01-01' ,2100);
insert into customer_orders values(4,100,'2022-01-02' ,2000);
insert into customer_orders values(5,400,'2022-01-02' ,2200);
insert into customer_orders values(6,500,'2022-01-02' ,2700);
insert into customer_orders values(7,100,'2022-01-03' ,3000);
insert into customer_orders values(8,400,'2022-01-03' ,1000);
insert into customer_orders values(9,600,'2022-01-03' ,3000);

with first_visit as (
  select customer_id, min(order_date) as first_date
  from customer_orders
  group by customer_id
  )
select 
	order_date, 
    count(*) as total_customer, 
    sum(first_time) as first_time, 
    count(*) - sum(first_time) as not_First_time
FROM
(
select  co.customer_id, 
	case when order_date = first_date then 1 else 0 end as first_time ,
    order_date, 
    first_date   
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
)
group by order_date

