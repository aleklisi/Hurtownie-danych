-- tu uruchom skrypt z stronki
-- hierarchia Daty
SELECT * FROM FactProductSales JOIN DimDate ON (DimDate.DateKey = FactProductSales.SalesDateKey); 
-- hierarchia Produkty
SELECT * FROM FactProductSales JOIN DimProduct ON (FactProductSales.ProductID = DimProduct.ProductKey); 
--hierarchia sklepy
SELECT * FROM FactProductSales JOIN DimStores ON (FactProductSales.StoreID = DimStores.StoreID); 
-- hierarchia Sprzedawcy
SELECT * FROM FactProductSales JOIN DimSalesPerson ON (FactProductSales.SalesPersonID = DimSalesPerson.SalesPersonID); 
