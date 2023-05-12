/* curso de udacity hablando de las principales funciones */
/* dudas principales, si todo lo hago con código en un editor como vs code, como se acceden a las  bases de datos? */
/* comandos básicos: 
select ____ from 
Limit _____
- se debe usar , para separar columnas deseadas dentro de la misma tabla
- se debe usar ; para tener más argumentos de diferentes tablas. 
- EDR, hay tres diferentes tipos de "tablas" 
*/

/* order by va despues de select y from. 
te ayuda a ordenar la info. el default de la info y su ordenamiento es de manera de bajo hacia alto. 
- a to z, lowest to highest, time as well. 
el sintaxis correcto es: 
ORDER BY {variable} DESC
y dentro de una orden es: 

"
SELECT * FROM {tabla}
ORDER BY {variable_columna} DESC
LIMIT 10
"

- the data is only ordered for that query but doesnt' actually rearrange anything on the database. 

- The ORDER BY statement always comes in a query after the SELECT and FROM statements, but before the LIMIT statement. If you are using the LIMIT statement, it will always appear last. 
- the default is to sort in ascending order.
*/

SELECT id, account_id, total_amt_usd FROM orders
ORDER BY total_amt_usd DESC, account_id ASC

/* WHERE is used to get information for a specific row + colum, for example a specific account or customer and all their orders. 
Using the WHERE statement, we can display subsets of tables based on conditions that must be met. You can also think of the WHERE command as filtering the data. 
Common symbols used in WHERE statements include:

> (greater than)

< (less than)

>= (greater than or equal to)

<= (less than or equal to)

= (equal to)

!= (not equal to)

- the WHERE goes after the SELECT FROM and before order by
*/
SELECT total_amt_usd FROM orders
WHERE total_amt_usd < 500
ORDER BY total_amt_usd DESC
limit 10

/* también se puede usar para filtrar montos, volumenes o numeros especificos como =, + grande que, menor que, etc. */

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* The WHERE statement can also be used with non-numeric data. The data has to be in  SINGLE quotes 'first name' in order to work. */

/* Derived columns are columns that in the "select " part you can add them together and it creates a new column. 
The syntax must also name the column if wanted, with an AS. you can do different arithmetic operations to create that new column


*/

SELECT id, account_id, 
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

/* Introduction to Logical Operators
In the next concepts, you will be learning about Logical Operators. Logical Operators include:

LIKE This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for.

IN This allows you to perform operations similar to using WHERE and =, but for more than one condition.

NOT This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

AND & BETWEEN These allow you to combine operations where all combined conditions must be true.

OR This allows you to combine operations where at least one of the combined conditions must be true. 

The LIKE operator is extremely useful for working with text. You will use LIKE within a WHERE clause. The LIKE operator is frequently used with %. The % tells us that we might want any number of characters leading up to a particular set of characters or following a certain set of characters */

/* Solutions to NOT LIKE Questions */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

/* Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'. */
SELECT name FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s'

/* Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest. */
SELECT * FROM web_events
WHERE occurred_at >= '2016-01-01%' AND channel = 'organic' OR channel = 'adwords'
/* Respuesta de la plataforma */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/* Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000. */
SELECT * FROM orders 
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000)

/* Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'. */

SELECT name FROM accounts
WHERE (name LIKE 'c%' or name LIKE 'w%') 
AND primary_poc LIKE 'ana%' and primary_poc not like '%eana'


