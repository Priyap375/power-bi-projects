# 1. Total Sales
select (quantityOrdered*priceEach)  as totalsales from orderdetails;
select sum((quantityOrdered*priceEach) ) as totalsales from orderdetails;



# 2. Total profit
 select sum((o.priceEach-p.buyPrice) *o.quantityOrdered)as TOTALprofit 
 from orderdetails o join products p on o.productCode = p.productCode;
 
# 3. Number of customers 
select count(customerNumber) from customers;


# 4. Total orders
select count(distinct(ordernumber))  from orders;

# 5. Top 5 Products that are ordered more in quantity
select * from orderdetails order by quantityordered desc limit 5;  


#6. Top 5 countries with most orders
Select c.country, Count(orderNumber) as totalOrders
from customers c 
join orders o
on c.customerNumber = o.customerNUMBER
group by c.country
order by count(orderNumber) desc
limit 5;


#7. Top 5 products with theis details
SELECT
  od.productCode,p.productname,p.MSRP,p.buyPrice,
  SUM(od.quantityordered) AS totalQuantityOrdered,
  COUNT(*) AS orderCount
FROM orderdetails od
join products p on p.productCode=od.productCode
GROUP BY productCode
ORDER BY totalQuantityOrdered DESC
LIMIT 5;

#8. Customer Names who ordered most orders.
SELECT customerName, COUNT(orderNumber) AS totalOrders,country 
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE customers.country = 'USA'
GROUP BY customerName
ORDER BY totalOrders DESC;


# 9. Top Product Lines which are ordered most in USA
SELECT c.customerName, p.productLine, COUNT(*) AS totalProductsPurchased
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE c.country = 'USA'
GROUP BY c.customerName, p.productLine
ORDER BY totalProductsPurchased DESC;


#10. Top sales representative 

SELECT e.employeeNumber, concat(e.firstName, e.lastName) as EmployeeName, SUM(p.amount) AS total_sales
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY total_sales DESC;


# 11. Customers who spend most on the products
select customerNumber, sum(amount) as total_payment from payments 
group by customerNumber order by total_payment desc limit 5; 


# 12.Sales by year
SELECT YEAR(paymentDate) as salesYear, SUM(amount) as totalSales
FROM payments
GROUP BY salesYear
ORDER BY totalSales DESC;



# 13.Average order value 
select avg(amount) FROM payments;


# VIEWS
 
# 14.
CREATE VIEW Sales_Per_Year AS
SELECT YEAR(paymentDate) AS salesYear, SUM(amount) AS totalSales
FROM payments
GROUP BY salesYear
ORDER BY totalSales DESC;
select * from Sales_Per_year;


# 15.
 CREATE VIEW Top5_Products AS
SELECT
  od.productCode, p.productName, p.MSRP, p.buyPrice,
  SUM(od.quantityOrdered) AS totalQuantityOrdered,
  COUNT(*) AS orderCount
FROM orderDetails od
JOIN products p ON p.productCode = od.productCode
GROUP BY od.productCode
ORDER BY totalQuantityOrdered DESC
LIMIT 5;


select * from Top5_products;

