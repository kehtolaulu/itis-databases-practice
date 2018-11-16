-- таблица products - (id, name, price), таблица sales (id, product_id, new_price, date)

create table products (
    id serial,
    name varchar(20),
    price integer,
    constraint pk_prod_id primary key (id)
);

create table sales (
    id serial,
    product_id integer,
    new_price integer,
    date timestamp,
    constraint pk_sales_id primary key (id),
    constraint fk_sales_prod foreign key (product_id) references products(id)
);

-- - сделать триггер, который проверяет, что новая цена меньше старой.

create function sales_log() returns trigger as $sales_log$
    begin
        if (TG_OP = 'INSERT') then
            if ()
            insert into sales (product_id, new_price, date) values (NEW.product_id, NEW.new_price, now());
        end if;
        return null;
    end;
$sales_log$ language plpgsql; 

create trigger sales_log after delete on sales
    for each row execute procedure sales_log();