---  1

SELECT
	pc.Name AS CategoryName,
	COUNT(DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY ProductCount DESC

---  2
SELECT
	pc.Name AS CategoryName,
	SUM(sod.LineTotal) AS TotalSales
FROM Production.ProductCategory pc
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY pc.Name
ORDER BY TotalSales DESC

---  3
SELECT
	FORMAT(OrderDate, 'yyyy-MM') AS SalesMonth,
	SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY
	FORMAT(OrderDate, 'yyyy-MM')
ORDER BY
	SalesMonth ASC

---  4
SELECT
	YEAR(OrderDate) AS SalesYear,
	COUNT(DISTINCT SalesOrderID) AS AntalOrdrar,
	SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY
	YEAR(OrderDate)
ORDER BY
	YEAR(OrderDate) ASC

---  5
SELECT TOP 10
	p.Name AS Namn,
	SUM(sod.LineTotal) AS TotalSales
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalSales DESC
---  6
SELECT
	COUNT(DISTINCT c.CustomerID) AS CustomerCount,
	st.Name AS Region,
	SUM(soh.TotalDue) AS TotalSales
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC

---  7
SELECT
    st.Name AS Region,
    CASE 
        WHEN c.StoreID IS NOT NULL THEN 'Store'
		ELSE 'Individual'
    END AS CustomerType,
    SUM(soh.TotalDue) / COUNT(DISTINCT soh.SalesOrderID) AS OrderValue
FROM Sales.SalesOrderHeader soh
LEFT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY
    st.Name,
    CASE 
        WHEN c.StoreID IS NOT NULL THEN 'Store'
		ELSE 'Individual'
    END
ORDER BY
    OrderValue DESC

