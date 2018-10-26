CREATE TABLE points (
  points       INTEGER,
  sportsman_id INTEGER,
  CONSTRAINT sportsman_fk FOREIGN KEY (sportsman_id) REFERENCES sportsman (id)
);

INSERT INTO sportsman (team_id, name)
VALUES (1, 'Ekaterina Boeva'),
       (2, 'Emiliya Garipova'),
       (3, 'Daler Uldashev'),
       (4, 'Dina Diyarova'),
       (5, 'Polina Alikina'),
       (2, 'Anastasia Zhuravleva'),
       (3, 'Mikhail Abramskiy'),
       (4, 'Edward Bolshakov');
SELECT *
from sportsman;

INSERT INTO points (points, sportsman_id)
VALUES (10, 1),
       (20, 2),
       (15, 3),
       (12, 4),
       (18, 5),
       (19, 6),
       (16, 7),
       (11, 8),
       (9, 9),
       (13, 10);

INSERT INTO points (points, sportsman_id)
values (12,10);

INSERT INTO points (points, sportsman_id) VALUES (15, 1),
                                                 (14, 2),
                                                 (9, 3),
                                                 (16, 4),
                                                 (17, 5),
                                                 (20, 6),
                                                 (10, 7),
                                                 (11, 8),
                                                 (18, 9);

CREATE VIEW sportsmenpoints as
  select *
  from sportsman inner join points p on sportsman.id = p.sportsman_id;

SELECT name, avg(points) AS p
FROM sportsmenpoints
GROUP BY name
ORDER BY p;

