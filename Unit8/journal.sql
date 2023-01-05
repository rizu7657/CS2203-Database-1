-- 1. Get all the orders placed by a specific customer. CustomerID for this customer is MAGAA
SELECT * FROM tblCustomers WHERE CustomerID = 'MAGAA';

-- 2. Show customers whose ContactTitle is not Sales Associate. Display CustomerID, CompanyName, Contact Name,
-- and ContactTitle
SELECT CustomerID, CompanyName, ContactName, ContactTitle FROM tblCustomers WHERE ContactTitle <> 'Sales Associate';

-- 3. Show customers who bought products where the EnglishName includes the string “chocolate”.
-- Display CustomerID, CompanyName, ProductID, ProductName, and EnglishName
SELECT c.CustomerID, c.CompanyName, od.ProductID, p.ProductName, p.EnglishName
from tblOrders o
    join tblCustomers c on o.CustomerID = c.CustomerID
    join tblOrderDetails od on o.OrderID = od.OrderID
    join tblProducts p on od.ProductID = p.ProductID
    WHERE od.ProductID in
        (SELECT ProductId
        FROM tblProducts
        WHERE EnglishName like'%chocolate%')
order by CompanyName;

-- 4. Show products which were bought by customers from Italy or USA. ”.
-- Display CustomerID, CompanyName, ShipCountry, ProductID, ProductName, and EnglishName
SELECT c.CustomerID, c.CompanyName, o.ShipCountry, p.ProductID, p.ProductName, p.EnglishName
FROM tblProducts p
    JOIN tblOrderDetails od ON p.ProductID = od.ProductID
    JOIN tblOrders o ON od.OrderID = o.OrderID
    JOIN tblCustomers c ON o.CustomerID = c.CustomerID
    WHERE c.Country in ('Italy', 'USA')
order by ProductName;
-- Both queries return the same result
select distinct p.ProductID, ProductName
from tblCustomers c
join tblOrders o on c.CustomerID = o.CustomerID
join tblOrderDetails od on o.OrderID = od.OrderID
join tblProducts p on od.ProductID = p.ProductID
where c.Country in ('Italy', 'USA')
order by ProductName

-- 5. Show total price of each product in each order. Note that there is not a column named as total price.
-- You should calculate it and create a column named as TotalPrice.
-- Display OrderID, ProductID, ProductName, UnitPrice, Quantity, Discount, and TotalPrice
select od.OrderID, od.ProductID, tP.ProductName, od.UnitPrice, od.Quantity, od.Discount,
       (od.UnitPrice * od.Quantity - ((od.UnitPrice * od.Quantity) * od.Discount)) as TotalPrice
from tblOrderDetails od
join tblProducts tP on tP.ProductID = od.ProductID

-- 6. Show how many products there are in each category and show the results in ascending order by the total
-- number of products. Display CategoryName, and TotalProducts
select c.CategoryName, COUNT(ProductID) as TotalProducts
from tblProducts p
join tblCategory c on p.CategoryID = c.CategoryID
group by c.CategoryName
order by TotalProducts
select ProductName from tblProducts-- 77 products

-- 7. Show the total number of customers in each City. Display Country, City, TotalCustomers
select Country, City, count(CustomerID) as TotalCustomers
from tblCustomers
group by Country, City
order by TotalCustomers desc

-- 8. Show the orders which were shipped late than the actual required date.
-- Display OrderID, OrderDate, RequiredDate, and ShippedDate
select OrderID, OrderDate, RequiredDate, ShippedDate
from tblOrders
where ShippedDate > RequiredDate