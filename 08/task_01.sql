-- создать таблицу пользователей user(id, name, email) И логов user_log (id, old_user_name, new_user_name, old_email, new_email, date, op_type) 

create table "user" (
    id serial,
    name varchar(20),
    email varchar(40),
    constraint pk_id primary key (id)
);

create table user_log (
    id serial,
    old_user_name varchar(20),
    new_user_name varchar(20),
    old_email varchar(40),
    new_email varchar(40),
    "date" timestamp,
    op_type varchar
);

-- - сделать триггеры, которые в таблицу добавляют значения (date- дата изменения, op_type - тип операции)

create function user_log_insert() returns trigger as $user_log_insert$
    begin
        if (TG_OP = 'INSERT') then 
            insert into user_log (id, new_user_name, new_email, "date", op_type) values (NEW.id, NEW.name, NEW.email, now(), TG_OP);
        end if;
        return null;
    end;
$user_log_insert$ language plpgsql;  

create trigger user_log_insert after insert on "user"
    for each row execute procedure user_log_insert();

create function user_log_delete() returns trigger as $user_log_delete$
    begin
        if (TG_OP = 'DELETE') then
            insert into user_log (id, old_user_name, old_email, "date", op_type) values (OLD.id, OLD.name, OLD.email, now(), TG_OP);
        end if;
        return null;
    end;
$user_log_delete$ language plpgsql; 

create trigger user_log_delete after delete on "user"
    for each row execute procedure user_log_delete();

create function user_log_update() returns trigger as $user_log_update$
    begin
        if (TG_OP = 'UPDATE') then u
            insert into user_log (id, old_user_name, old_email, new_user_name, new_email, "date", op_type) values (OLD.id, OLD.name, OLD.email, NEW.name, NEW.email, now(), TG_OP);
        end if;
        return null;
    end;
$user_log_update$ language plpgsql; 

create trigger user_log_update after update on "user"
    for each row execute procedure user_log_update();

insert into "user" (name, email) values ('maxim3', 'max3@mail.ru'), ('dima3', 'dima3@mail.ru');
update "user" set name = 'emilya', email = 'emilya@mail.ru' where id = 13;
delete from "user" where id = 14;
select * from user_log;
