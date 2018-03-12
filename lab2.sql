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
	SELECT [IDzamówienia]
      ,Year([DataZamówienia])
      ,DATEPART(QUARTER, [DataZamówienia])
      ,month([DataZamówienia]) 
      ,day([DataZamówienia])   
	  FROM [BAZA].[dbo].[Zamówienia]
;