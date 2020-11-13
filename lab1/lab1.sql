/*
Lab 1 report <Johanna Gerhardsen,johge201 and Sofia Bertmar, sofbe892>
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
1) List all employees, i.e. all tuples in the jbemployee relation.
*/

SELECT *
FROM jbemployee;

/*'10', 'Ross, Stanley', '15908', '199', '1927', '1945'
'11', 'Ross, Stuart', '12067', NULL, '1931', '1932'
'13', 'Edwards, Peter', '9000', '199', '1928', '1958'
'26', 'Thompson, Bob', '13000', '199', '1930', '1970'
'32', 'Smythe, Carol', '9050', '199', '1929', '1967'
'33', 'Hayes, Evelyn', '10100', '199', '1931', '1963'
'35', 'Evans, Michael', '5000', '32', '1952', '1974'
'37', 'Raveen, Lemont', '11985', '26', '1950', '1974'
'55', 'James, Mary', '12000', '199', '1920', '1969'
'98', 'Williams, Judy', '9000', '199', '1935', '1969'
'129', 'Thomas, Tom', '10000', '199', '1941', '1962'
'157', 'Jones, Tim', '12000', '199', '1940', '1960'
'199', 'Bullock, J.D.', '27000', NULL, '1920', '1920'
'215', 'Collins, Joanne', '7000', '10', '1950', '1971'
'430', 'Brunet, Paul C.', '17674', '129', '1938', '1959'
'843', 'Schmidt, Herman', '11204', '26', '1936', '1956'
'994', 'Iwano, Masahiro', '15641', '129', '1944', '1970'
'1110', 'Smith, Paul', '6000', '33', '1952', '1973'
'1330', 'Onstad, Richard', '8779', '13', '1952', '1971'
'1523', 'Zugnoni, Arthur A.', '19868', '129', '1928', '1949'
'1639', 'Choy, Wanda', '11160', '55', '1947', '1970'
'2398', 'Wallace, Maggie J.', '7880', '26', '1940', '1959'
'4901', 'Bailey, Chas M.', '8377', '32', '1956', '1975'
'5119', 'Bono, Sonny', '13621', '55', '1939', '1963'
'5219', 'Schwarz, Jason B.', '13374', '33', '1944', '1959'
*/

/*2) List the name of all departments in alphabetical order. Note: by ?name? we mean
the name attribute for all tuples in the jbdept relation.*/

SELECT name
FROM jbdept
ORDER BY name ASC;

/*'Bargain'
'Book'
'Candy'
'Children\'s'
'Children\'s'
'Furniture'
'Giftwrap'
'Jewelry'
'Junior Miss'
'Junior\'s'
'Linens'
'Major Appliances'
'Men\'s'
'Sportswear'
'Stationary'
'Toys'
'Women\'s'
'Women\'s'
'Women\'s'
*/

/* 3) What parts are not in store, i.e. qoh = 0? (qoh = Quantity On Hand)*/

SELECT *
FROM jbparts
WHERE qoh = 0;

/*'11', 'card reader', 'gray', '327', '0'
'12', 'card punch', 'gray', '427', '0'
'13', 'paper tape reader', 'black', '107', '0'
'14', 'paper tape punch', 'black', '147', '0'
*/

/*4) Which employees have a salary between 9000 (included) and 10000 (included)?*/

SELECT *
FROM jbemployee
WHERE salary <= 10000 AND salary >= 9000;

/*'13', 'Edwards, Peter', '9000', '199', '1928', '1958'
'32', 'Smythe, Carol', '9050', '199', '1929', '1967'
'98', 'Williams, Judy', '9000', '199', '1935', '1969'
'129', 'Thomas, Tom', '10000', '199', '1941', '1962'
*/

/*5) What was the age of each employee when they started working (startyear)?*/
SELECT id, name, birthyear, startyear, (startyear - birthyear) as startage
FROM jbemployee;

/*'10', 'Ross, Stanley', '1927', '1945', '18'
'11', 'Ross, Stuart', '1931', '1932', '1'
'13', 'Edwards, Peter', '1928', '1958', '30'
'26', 'Thompson, Bob', '1930', '1970', '40'
'32', 'Smythe, Carol', '1929', '1967', '38'
'33', 'Hayes, Evelyn', '1931', '1963', '32'
'35', 'Evans, Michael', '1952', '1974', '22'
'37', 'Raveen, Lemont', '1950', '1974', '24'
'55', 'James, Mary', '1920', '1969', '49'
'98', 'Williams, Judy', '1935', '1969', '34'
'129', 'Thomas, Tom', '1941', '1962', '21'
'157', 'Jones, Tim', '1940', '1960', '20'
'199', 'Bullock, J.D.', '1920', '1920', '0'
'215', 'Collins, Joanne', '1950', '1971', '21'
'430', 'Brunet, Paul C.', '1938', '1959', '21'
'843', 'Schmidt, Herman', '1936', '1956', '20'
'994', 'Iwano, Masahiro', '1944', '1970', '26'
'1110', 'Smith, Paul', '1952', '1973', '21'
'1330', 'Onstad, Richard', '1952', '1971', '19'
'1523', 'Zugnoni, Arthur A.', '1928', '1949', '21'
'1639', 'Choy, Wanda', '1947', '1970', '23'
'2398', 'Wallace, Maggie J.', '1940', '1959', '19'
'4901', 'Bailey, Chas M.', '1956', '1975', '19'
'5119', 'Bono, Sonny', '1939', '1963', '24'
'5219', 'Schwarz, Jason B.', '1944', '1959', '15'
*/

/*6) Which employees have a last name ending with ?son??*/
SELECT id,name
FROM jbemployee
WHERE name LIKE '%son,%';

/*'26', 'Thompson, Bob'
*/

/*7) Which items (note items, not parts) have been delivered by a supplier called
Fisher-Price? Formulate this query using a subquery in the where-clause.*/

SELECT I.name, I.supplier, S.name
FROM jbitem AS I, jbsupplier AS S
WHERE EXISTS (SELECT S.id, S.name FROM jbsupplier WHERE I.supplier = S.id AND S.name = 'Fisher-Price');

/*'Maze', '89', 'Fisher-Price'
'The \'Feel\' Book', '89', 'Fisher-Price'
'Squeeze Ball', '89', 'Fisher-Price'
*/

/*8) Formulate the same query as above, but without a subquery.*/

SELECT jbitem.name, jbitem.supplier, jbsupplier.name
FROM jbitem, jbsupplier
WHERE jbitem.supplier = jbsupplier.id AND jbsupplier.name = 'Fisher-Price';
/*'Maze', '89', 'Fisher-Price'
'The \'Feel\' Book', '89', 'Fisher-Price'
'Squeeze Ball', '89', 'Fisher-Price'
*/

/*9) Show all cities that have suppliers located in them. Formulate this query using a
subquery in the where-clause.*/
SELECT C.name
FROM jbsupplier AS S, jbcity AS C
WHERE EXISTS (SELECT C.id, C.name FROM jbcity WHERE S.city = C.id);

/*'Amherst'
'Boston'
'New York'
'White Plains'
'Hickville'
'Atlanta'
'Atlanta'
'Madison'
'Paxton'
'Dallas'
'Denver'
'Salt Lake City'
'Los Angeles'
'San Diego'
'San Francisco'
'Seattle'
*/

/*10) What is the name and color of the parts that are heavier than a card reader?
Formulate this query using a subquery in the where-clause. (The SQL query must
not contain the weight as a constant.)*/
SELECT name, color, weight
FROM jbparts
WHERE weight > (SELECT weight FROM jbparts WHERE name = 'card reader');

/*'disk drive', 'black', '685'
'tape drive', 'black', '450'
'line printer', 'yellow', '578'
'card punch', 'gray', '427'
*/

/*11) Formulate the same query as above, but without a subquery. (The query must not
contain the weight as a constant.)*/
SELECT B.name, B.color, B.weight
FROM jbparts A, jbparts B
WHERE A.name = 'card reader' AND A.weight < B.weight; 

/*'disk drive', 'black', '685'
'tape drive', 'black', '450'
'line printer', 'yellow', '578'
'card punch', 'gray', '427'
*/

/*12) What is the average weight of black parts?*/
SELECT color, AVG(weight)
FROM jbparts
WHERE color = 'black';

/*'black', '347.2500'
*/

/*13) What is the total weight of all parts that each supplier in Massachusetts (?Mass?)
has delivered? Retrieve the name and the total weight for each of these suppliers.
Do not forget to take the quantity of delivered parts into account. Note that one
row should be returned for each supplier.*/
SELECT S.name, C.state, SUM(P.weight*SUP.quan) AS totalweight
FROM jbparts AS P, jbsupply AS SUP, jbsupplier AS S, jbcity AS C
WHERE EXISTS (SELECT C.state, C.id FROM jbcity WHERE S.city = C.id AND C.state = 'Mass' AND S.id = SUP.supplier AND SUP.part = P.id)
group BY S.name;
/*'DEC', 'Mass', '3120'
'Fisher-Price', 'Mass', '1135000'
*/

/*14) Create a new relation (a table), with the same attributes as the table items using
the CREATE TABLE syntax where you define every attribute explicitly (i.e. not
as a copy of another table). Then fill the table with all items that cost less than the
average price for items. Remember to define primary and foreign keys in your
table!*/
create table newtable as select * from jbitem where 0=1;

INSERT INTO newtable
SELECT *
FROM jbitem
WHERE price < (SELECT AVG(price) FROM jbitem);

SELECT *
FROM newtable;

/*'11', 'Wash Cloth', '1', '75', '575', '213'
'19', 'Bellbottoms', '43', '450', '600', '33'
'21', 'ABC Blocks', '1', '198', '405', '125'
'23', '1 lb Box', '10', '215', '100', '42'
'25', '2 lb Box, Mix', '10', '450', '75', '42'
'26', 'Earrings', '14', '1000', '20', '199'
'43', 'Maze', '49', '325', '200', '89'
'106', 'Clock Book', '49', '198', '150', '125'
'107', 'The \'Feel\' Book', '35', '225', '225', '89'
'118', 'Towels, Bath', '26', '250', '1000', '213'
'119', 'Squeeze Ball', '49', '250', '400', '89'
'120', 'Twin Sheet', '26', '800', '750', '213'
'165', 'Jean', '65', '825', '500', '33'
'258', 'Shirt', '58', '650', '1200', '33'
*/

/*15) Create a view that contains the items that cost less than the average price for
items. */

CREATE VIEW view1 as select * from jbitem WHERE price < (SELECT AVG(price) FROM jbitem);

SELECT *
FROM view1;

/*'11', 'Wash Cloth', '1', '75', '575', '213'
'19', 'Bellbottoms', '43', '450', '600', '33'
'21', 'ABC Blocks', '1', '198', '405', '125'
'23', '1 lb Box', '10', '215', '100', '42'
'25', '2 lb Box, Mix', '10', '450', '75', '42'
'26', 'Earrings', '14', '1000', '20', '199'
'43', 'Maze', '49', '325', '200', '89'
'106', 'Clock Book', '49', '198', '150', '125'
'107', 'The \'Feel\' Book', '35', '225', '225', '89'
'118', 'Towels, Bath', '26', '250', '1000', '213'
'119', 'Squeeze Ball', '49', '250', '400', '89'
'120', 'Twin Sheet', '26', '800', '750', '213'
'165', 'Jean', '65', '825', '500', '33'
'258', 'Shirt', '58', '650', '1200', '33'
*/

/*16) What is the difference between a table and a view? One is static and the other is
dynamic. Which is which and what do we mean by static respectively dynamic?

A view is a virtual table which is derived from other tables that are also possibly virtual. This means that a view is always up-to-date and therefore dynamic, whereas a table is static as it is not up to date. 
So what this entails is that the contents of views are defined by a query, and it does therefore not exist in a database as a stored set of values. Therefore views can consist of a combination of both rows and columns from tables or other views. 

*/

/*17) Create a view that calculates the total cost of each debit, by considering price and
quantity of each bought item. (To be used for charging customer accounts). The
view should contain the sale identifier (debit) and total cost. Use only the implicit
join notation, i.e. only use a where clause but not the keywords inner join, right
join or left join,*/
CREATE VIEW otherview1
as SELECT S.debit, SUM(I.price*S.quantity) AS totcost
FROM jbsale AS S, jbitem AS I, jbdebit AS D
WHERE EXISTS (SELECT D.id FROM jbdebit WHERE D.id = S.debit AND S.item = I.id)
group BY S.debit;

SELECT *
FROM otherview1;
/*'100586', '13446'
'100594', '3295'
'100581', '2050'
'100582', '1000'
'100592', '650'
'100593', '430'
*/

/*18) Do the same as in (17), using only the explicit join notation, i.e. using only left,
right or inner joins but no join condition in a where clause. Motivate why you use
the join you do (left, right or inner), and why this is the correct one (unlike the
others).*/

CREATE VIEW altview
as SELECT S.debit, SUM(I.price*S.quantity) AS totcast
FROM jbsale AS S 
INNER JOIN jbdebit AS D ON D.id = S.debit
INNER JOIN jbitem AS I ON S.item = I.id
group BY S.debit;

SELECT *
FROM altview;

/*'100581', '2050'
'100582', '1000'
'100586', '13446'
'100592', '650'
'100593', '430'
'100594', '3295'

We use inner join to only return the connected matching rows. We don't want to connect rows that don't match, therefore
this is the correct join to chose!
*/

/*19) Oh no! An earthquake!
a) Remove all suppliers in Los Angeles from the table jbsupplier. This will not
work right away (you will receive error code 23000) which you will have to
solve by deleting some other related tuples. However, do not delete more
tuples from other tables than necessary and do not change the structure of the
tables, i.e. do not remove foreign keys. Also, remember that you are only
allowed to use ?Los Angeles? as a constant in your queries, not ?199? or
?900?.
b) Explain what you did and why.*/

/*DELETE
FROM jbsupplier  
WHERE EXISTS (SELECT id, name FROM jbcity WHERE jbsupplier.city = jbcity.id AND jbcity.name = 'Los Angeles');*/

/*20) An employee has tried to find out which suppliers that have delivered items that
have been sold. He has created a view and a query that shows the number of items
sold from a supplier.
mysql> CREATE VIEW jbsale_supply(supplier, item, quantity) AS
 -> SELECT jbsupplier.name, jbitem.name, jbsale.quantity
 -> FROM jbsupplier, jbitem, jbsale
 -> WHERE jbsupplier.id = jbitem.supplier
 -> AND jbsale.item = jbitem.id;
Query OK, 0 rows affected (0.01 sec)
mysql> SELECT supplier, sum(quantity) AS sum FROM jbsale_supply
 -> GROUP BY supplier;
+--------------+---------------+
| supplier | sum(quantity) |
+--------------+---------------+
| Cannon | 6 |
| Levi-Strauss | 1 |
| Playskool | 2 |
| White Stag | 4 |
| Whitman's | 2 |
+--------------+---------------+
5 rows in set (0.00 sec)

The employee would also like include the suppliers which has delivered some
items, although for whom no items have been sold so far. In other words he wants
to list all suppliers, which has supplied any item, as well as the number of these
items that have been sold. Help him! Drop and redefine jbsale_supply to
consider suppliers that have delivered items that have never been sold as well.*/

CREATE VIEW jbsale_supply(supplier, item, quantity) AS
SELECT jbsupplier.name, jbitem.name, jbsale.quantity
FROM jbsupplier LEFT JOIN jbitem ON jbsupplier.id = jbitem.supplier
LEFT JOIN jbsale ON jbsale.item = jbitem.id;

SELECT supplier, sum(quantity) AS sum FROM jbsale_supply
GROUP BY supplier;

/*'A E Neumann', NULL
'Amdahl', NULL
'Cannon', '6'
'Data General', NULL
'DEC', NULL
'Edger', NULL
'Fisher-Price', NULL
'IBM', NULL
'Koret', '1'
'Levi-Strauss', '1'
'Playskool', '2'
'Spooley', NULL
'White Paper', NULL
'White Stag', '4'
'Whitman\'s', '2'
'Wormley', NULL

Here we use a left join so that all supplier show upp, even though they don't have a sale.
*/