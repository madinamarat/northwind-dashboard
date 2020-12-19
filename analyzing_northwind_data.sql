/*1.Get the names and the quantities in stock for each product.*/
SELECT productname, unitsinstock FROM products;

/*2.Get a list of current products (Product ID and name).*/
SELECT productid, productname FROM products WHERE discontinued=0;

/*3.Get a list of the most and least expensive products (name and unit price).*/
SELECT unitprice, productname FROM products ORDER BY unitprice DESC LIMIT 1;
SELECT unitprice, productname FROM products ORDER BY unitprice LIMIT 1;

/*4.Get products that cost less than $20.*/
SELECT productname, unitprice FROM products WHERE unitprice<20;

/*5.Get products that cost between $15 and $25.*/
SELECT productname, unitprice FROM products WHERE unitprice BETWEEN 15 AND 25;

/*6.Get products above average price.*/
SELECT productname, unitprice FROM products WHERE (unitprice) > (SELECT avg(unitprice) FROM products) ORDER BY unitprice DESC;

/*7.Find the ten most expensive products.*/
SELECT unitprice, productname FROM products ORDER BY unitprice DESC LIMIT 10;

/*8.Get a list of discontinued products (Product ID and name).*/
SELECT productid, productname FROM products WHERE discontinued=1;

/*9.Count current and discontinued products.*/
SELECT COUNT(discontinued) FROM products WHERE discontinued=1;
SELECT COUNT(discontinued) FROM products WHERE discontinued=0;

/*10.Find products with less units in stock than the quantity on order.*/
SELECT productname FROM products WHERE unitsinstock<unitsonorder;

/*11.Find the customer who had the highest order amount*/ 
SELECT MAX(quantity), customerid FROM order_details, orders GROUP BY customerid; --how to take the name of the customer instead of id

/*12.Get orders for a given employee and the according customer*/
SELECT lastname, orderid FROM employees, orders ORDER BY lastname;

/*13.Find the hiring age of each employee*/
SELECT lastname, SUBSTRING(CAST((hiredate - birthdate)/365 AS VARCHAR(50)),1,2) as hiringage FROM employees;

/*14.Create views and/or named queries for some of these queries*/
CREATE VIEW hiringage as
	SELECT lastname, SUBSTRING(CAST((hiredate - birthdate)/365 AS VARCHAR(50)),1,2) as hiringage FROM employees;
