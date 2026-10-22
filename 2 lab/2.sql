insert into users (name, email, phone, role)
select
	'user_' || g,
	'user' || g || '@.ru',
	'+7' || floor(9000000000 + random() * 100000000)::bigint,
	case when (random() < 0.14) then 'seller' else 'reviewer' end
from generate_series(1,1000) as g;

insert into orders (user_id, status, total_amount)
select
	floor(1 + random() * 1000)::int,
	 case
        when random() < 0.20 then 'Принят'
        when random() < 0.50 then 'Оплачен'
        when random() < 0.80 then 'Едет'
        else 'Доставлен'
        end,
	floor(100 + random() * 10000)::int
from generate_series(1,1000);

insert into sellers (user_id, store_name, description)
select
	r,
	'Магазин_' || r,
	'Описание_' || r
from generate_series(1,50) as r;

insert into categories (parent_id, name)
select
	r,
	'Категория_' || r
from generate_series(1,50) as r;

insert into products (seller_id, category_id, title, description, price)
select
	floor(1 + random() * 50),
	floor(1 + random() * 10),
	'Название_' || r,
	'Описание_' || r,
	floor(10 + random() * 200)
from generate_series(1,1000) as r;

insert into stock (product_id, quantity)
select
	r,
	floor(1 + random() * 100)
from generate_series(1,50) as r;

insert into carts (user_id)
select
	floor(1 + random() * 1000)
from generate_series(1,50) as r;

insert into cart_items (cart_id, product_id, quantity)
select
	r,
	floor(1 + random() * 1000),
	floor(1 + random() * 10)
from generate_series(1,50) as r;

insert into order_items (order_id, product_id, quantity, unit_price)
select
	floor(1 + random() * 1000),
	floor(1 + random() * 1000),
	floor(1 + random() * 10),
	floor(10 + random() * 200)
from generate_series(1,50) as r;

insert into reviews (user_id, product_id, score, comment)
select
	floor(1 + random() * 1000),
	floor(1 + random() * 1000),
	floor(1 + random() * 5),
	'Комментарий_' || r
from generate_series(1,50) as r;

insert into payments (order_id, amount, status)
select
	r,
	floor(100 + random() * 10000),
	case
        when random() < 0.80 then 'Оплачен'
        else 'Ждёт оплаты'
        end
from generate_series(1,1000) as r;

insert into addresses (user_id, city, street, house, apartment)
select
	floor(1 + random() * 100),
	'Город_' || r,
	'Улица_' || r,
	'Дом_' || r,
	'Квартира_' || r
from generate_series(1,100) as r;

insert into deliveries (order_id, address_id, delivery_status)
select
	floor(1 + random() * 1000),
	floor(1 + random() * 100),
	case
        when random() < 0.20 then 'Ожидает отправления'
        when random() < 0.50 then 'Едет'
        else 'Доставлен'
        end
from generate_series(1,30) as r;

select distinct title from products;

select status, total_amount from orders
where status in ('Принят', 'Едет') and total_amount between 1000 and 2000;

select status, amount from payments
where status LIKE 'Ждёт%' or status is null
order by amount ASC;

select total_amount from orders
order by total_amount DESC
limit 100 offset 900;