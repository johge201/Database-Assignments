/*
Lab 1 report <Student_names and liu_id>
*/

/* All non code should be within SQL-comments like this */ 


/*
Drop all user created tables that have been created when solving the lab
*/

DROP TABLE IF EXISTS newtable CASCADE;
DROP VIEW IF EXISTS view1;
DROP VIEW IF EXISTS otherview1;
DROP VIEW IF EXISTS altview;


/*
Question 1: Print a message that says "hello world"
*/

SELECT *
FROM jbemployee;

SELECT name
FROM jbdept
ORDER BY name ASC;

SELECT *
FROM jbparts
WHERE qoh = 0;

SELECT *
FROM jbemployee
WHERE salary <= 10000 AND salary >= 9000;

select id, name, birthyear, startyear, (startyear - birthyear) as startage
FROM jbemployee;

SELECT id,name
FROM jbemployee
WHERE name LIKE '%son,%';

SELECT I.name, I.supplier, S.name
FROM jbitem AS I, jbsupplier AS S
WHERE EXISTS (SELECT S.id, S.name FROM jbsupplier WHERE I.supplier = S.id AND S.name = 'Fisher-Price');

SELECT jbitem.name, jbitem.supplier, jbsupplier.name
FROM jbitem, jbsupplier
WHERE jbitem.supplier = jbsupplier.id AND jbsupplier.name = 'Fisher-Price';

SELECT C.name
FROM jbsupplier AS S, jbcity AS C
WHERE EXISTS (SELECT C.id, C.name FROM jbcity WHERE S.city = C.id);

SELECT name, color, weight
FROM jbparts
WHERE weight > (SELECT weight FROM jbparts WHERE name = 'card reader');

SELECT B.name, B.color, B.weight
FROM jbparts A, jbparts B
WHERE A.name = 'card reader' AND A.weight < B.weight; 

SELECT color, AVG(weight)
FROM jbparts
WHERE color = 'black';

SELECT S.name, C.state, SUM(P.weight*SUP.quan) AS totalweight
FROM jbparts AS P, jbsupply AS SUP, jbsupplier AS S, jbcity AS C
WHERE EXISTS (SELECT C.state, C.id FROM jbcity WHERE S.city = C.id AND C.state = 'Mass' AND S.id = SUP.supplier AND SUP.part = P.id)
group BY S.name;

create table newtable as select * from jbitem where 0=1;

INSERT INTO newtable
SELECT *
FROM jbitem
WHERE price < (SELECT AVG(price) FROM jbitem);

SELECT *
FROM newtable;

CREATE VIEW view1 as select * from jbitem WHERE price < (SELECT AVG(price) FROM jbitem);

SELECT *
FROM view1;

CREATE VIEW otherview1
as SELECT S.debit, SUM(I.price*S.quantity) AS totcast
FROM jbsale AS S, jbitem AS I, jbdebit AS D
WHERE EXISTS (SELECT D.id FROM jbdebit WHERE D.id = S.debit AND S.item = I.id)
group BY S.debit;

SELECT *
FROM otherview1;

CREATE VIEW altview
as SELECT S.debit, SUM(I.price*S.quantity) AS totcast
FROM jbsale AS S, jbitem AS I, jbdebit AS D
WHERE 
