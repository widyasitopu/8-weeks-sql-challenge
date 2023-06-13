create schema pizza_runner;

create table runners(
	runner_id integer,
    registration_date date
);

insert into runners(runner_id, registration_date)
values
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');

select * from runners;

create table customer_orders(
	order_id integer,
    customer_id integer,
    pizza_id integer,
    exclusions varchar(10),
    extras varchar(10),
    order_time datetime
);

insert into customer_orders(order_id, customer_id, pizza_id, exclusions, extras, order_time)
values
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', null, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
  
select * from customer_orders; 

-- update null and 'null' values to empty string
update customer_orders
set exclusions = coalesce(nullif(exclusions, 'null'), ''), extras = coalesce(nullif(extras, 'null'), '')
where exclusions is null or exclusions = 'null' or extras is null or extras = 'null';

create table runner_orders(
	order_id integer,
    runner_id integer,
    pickup_time datetime,
    distance float,
    duration integer,
    cancellation varchar(50)
);

insert into runner_orders(order_id, runner_id, pickup_time, distance, duration, cancellation)
values
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', null),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', null),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', null),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');

select * from runner_orders;

-- update column duration as time 
alter table runner_orders add duration_time time after duration;
update runner_orders set duration_time = sec_to_time(duration * 60);
alter table runner_orders drop column duration;
alter table runner_orders change column duration_time duration TIME;

-- update null and 'null' values to empty string
update runner_orders
set cancellation = coalesce(nullif(cancellation, 'null'), '')
where cancellation is null or cancellation = 'null';

select distinct * from runner_orders;

create table pizza_names(
  pizza_id integer,
  pizza_name text
);

insert into pizza_names(pizza_id, pizza_name)
values
  (1, 'Meatlovers'),
  (2, 'Vegetarian');

select * from pizza_names;

create table pizza_recipes(
  pizza_id integer,
  toppings text
);

insert into pizza_recipes(pizza_id, toppings)
values
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');

select * from pizza_recipes;

create table pizza_toppings(
  topping_id integer,
  topping_name text
);

insert into pizza_toppings(topping_id, topping_name)
values
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
select * from pizza_toppings;
