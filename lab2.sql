USE BAZA
GO

CREATE TABLE [dbo].[DataZamowienia] (
	IDZamowienia INT,
	Rok INT,
	Kawrtal INT,
	Miesiac INT,
	Dzien INT,
	PRIMARY KEY (IDZamowienia)
	);

INSERT INTO [dbo].[DataZamowienia]
	SELECT [IDzamowienia]
      ,Year([DataZamówienia])
      ,DATEPART(QUARTER, [DataZamówienia])
      ,month([DataZamówienia]) 
      ,day([DataZamówienia])   
	  FROM [BAZA].[dbo].[Zamówienia]
;
GO 

USE BAZA
GO

CREATE TABLE [dbo].[AdresOdbiorcy] (
	IDklienta nvarchar(20),
	Kraj VARCHAR(MAX),
	Region VARCHAR(MAX),
	Miasto VARCHAR(MAX),
	NazwaFirmy VARCHAR(MAX),
	PRIMARY KEY (IDklienta)
	);
GO

INSERT INTO [dbo].[AdresOdbiorcy]
SELECT [IDklienta]
      ,[Kraj]
      ,[Region]
      ,[Miasto]
      ,[NazwaFirmy]
  FROM [BAZA].[dbo].[Klienci];
  
 GO

 CREATE TABLE [dbo].[ProduktyLab] (
	IDproduktu INT,
	NazwaProduktu VARCHAR(MAX),
	Kategoria VARCHAR(MAX),
	PRIMARY KEY ([IDproduktu])
	);
GO

INSERT INTO [dbo].[ProduktyLab]
SELECT [IDproduktu]
      ,[NazwaProduktu]
	  ,NULL
  FROM [BAZA].[dbo].[Produkty];
 go
 --Data Zamowienia

SELECT [Rok]
      ,[Kawrtal]
      ,[Miesiac]
      ,[Dzien]
  FROM [BAZA].[dbo].[DataZamowienia];
--Produkty
Select NazwaProduktu,NazwaKategorii from [BAZA].[dbo].[Produkty wg kategorii];
--Adres odbiorcy
SELECT *
  FROM [BAZA].[dbo].[AdresOdbiorcy];
-- Spedytorzy 
  Select * from [BAZA].[dbo].[Spedytorzy];