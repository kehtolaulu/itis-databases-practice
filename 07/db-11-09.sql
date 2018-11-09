CREATE TABLE employee (
  id            serial not null,
  name          varchar(20),
  salary        integer,
  department_id integer,
  manager_id    integer,
  constraint pk_employee primary key (id),
  constraint fk_dep_id foreign key (department_id) references department (id),
  constraint fk_man_id foreign key (manager_id) references employee (id)
);
4

CREATE TABLE department (
  id   serial not null,
  name varchar(20),
  constraint pk_department primary key (id)
);
2

INSERT into department (name)
values ('department1'),
       ('department2');
INSERT into department (name)
values ('department3');

INSERT into employee (name, salary, department_id)
values ('John Smith', 15000, 1);

INSERT into employee (name, salary, department_id, manager_id)
values ('Albert Einstein', 10000, 1, 1);

INSERT into employee (name, salary, department_id)
values ('Daler Uldashev', 12000, 2);

INSERT into employee (name, salary, department_id, manager_id)
values ('Maxim Pichkalev', 10000, 2, 3);

INSERT into employee (name, salary, department_id, manager_id)
values ('Edward Bolshakov', 20000, 2, 3);

INSERT into employee (name, salary, department_id, manager_id)
values ('Stepa', 20000, 1, 3);

INSERT into employee(name, salary, department_id)
values ('Dima', 140000, 5), ('Emilya', 150000, 5), ('Andrey', 180000,5), ('Evelina', 2000000,5);
-- вывести такие отделы, в которых средняя зп больше 10

SELECT DISTINCT d.id, d.name, avg(e.salary) as avg_salary
from department d
       inner join employee e on d.id = e.department_id
group by d.id
having avg(salary) > 10000;

-- вывести департамент, в котором наибольшая зп у сотрудников

SELECT *
from (SELECT DISTINCT d.id, d.name, avg(e.salary) as avg_salary
      from department d
             inner join employee e on d.id = e.department_id
      group by d.id) as dep_avg_salary
WHERE avg_salary = (SELECT max(avg_salary) from dep_avg_salary);


with s as (SELECT DISTINCT d.id, d.name, avg(e.salary) as avg_salary
      from department d
             inner join employee e on d.id = e.department_id
      group by d.id),
SELECT *
from s
WHERE avg_salary = (SELECT max(avg_salary) from s);

-- Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя

SELECT *
from employee e
where e.salary > (SELECT DISTINCT salary from employee where id = e.manager_id);

-- Вывести список сотрудников, получающих максимальную заработную плату в своем отделе

SELECT *
from employee e
where e.salary = (SELECT max(salary) from employee where department_id = e.department_id);

-- Вывести список названий  отделов, количество сотрудников в которых не превышает 3 человек

SELECT DISTINCT name FROM department d WHERE (SELECT count(*) FROM employee WHERE department_id = d.id) <= 3;

-- 09.11.2018

-- Вывести список названий  отделов, количество сотрудников в которых не превышает 3 человек

SELECT d.name FROM department d LEFT JOIN employee e
ON d.id = e.department_id
GROUP BY d.name
HAVING count(e.id) <= 3;

-- Вывести список названий отделов с максимальной суммарной зарплатой сотрудников

WITH dep_sum_salary AS (SELECT DISTINCT d.name, sum(e.salary) as sum_salary
                        FROM department d INNER JOIN employee e ON d.id = e.department_id
                        GROUP BY d.id)
SELECT *
FROM dep_sum_salary
WHERE sum_salary = (SELECT max(sum_salary) from dep_sum_salary);

-- Вывести список сотрудников, у которых руководитель работает в другом отделе

SELECT e.name FROM employee e 
INNER JOIN employee m ON e.manager_id = m.id 
WHERE e.department_id != m.department_id; 





