--1. Utworzyć bazę danych [BAZA]

USE master;  
GO  

--Delete the baza database if it exists.  
IF EXISTS(SELECT * from sys.databases WHERE name='BAZA')  
BEGIN  
    DROP DATABASE BAZA;  
END

CREATE DATABASE BAZA;
GO

USE BAZA
GO
--2. Przygotować zapytanie w SQL, tworzące pustą tabelę [Zamówienia] w [BAZA], która ma być potem wypełniona danymi pochodzącymi z pliku Excela

CREATE TABLE [dbo].[Zamowienia] (
	RowID INT,
	OrderID	INT,
	OrderDate DATE,
	OrderPriority VARCHAR(255),	
	OrderQuantity INT,
	Sales money,
	Discount DECIMAL,
	ShipMode VARCHAR(255),
	Profit money,
	UnitPrice money,
	ShippingCost money,
	CustomerName VARCHAR(255),
	Province VARCHAR(255),
	Region VARCHAR(255),
	CustomerSegment	VARCHAR(255),
	ProductCategory	VARCHAR(255),
	ProductSub-Category	VARCHAR(255),
	ProductName	VARCHAR(1024),
	ProductContainer VARCHAR(255),
	ProductBaseMargin DECIMAL(3,2),
	ShipDate DATE,
	PRIMARY KEY (RowID)
	)

--3. Otworzyć SQL Server Data Tools
--a) Utworzyć nowy projekt: NEW > PROJECT > TEMPLATES > BUSINESS INTELLIGENCE > INTEGRATION SERVICES > INTEGRATION SERVICES PROJECT
--b) W SOLUTION MANAGER > CONNECTION MANAGERS > NEW CONNECTION MANAGER; wybrać typ OLE DB; nacisnąć ADD...; nacisnąć NEW... i dodać połączenie z bazą [BAZA]
--c) Z SSIS TOOLBOX wybrać EXECUTE SQL TASK i przeciągnąć na kartę CONTROL FLOW (Bloczek [Stworzenie tabeli Zamówienia w bazie BAZA])
--d) Kliknąć dwukrotnie nowy bloczek i wprowadzić stworzony SQL STATEMENT; uzupełnić pole CONNECTION
--e) Wykonać bloczek [Stworzenie tabeli Zamówienia w bazie BAZA] (w [BAZA] powinna powstać tabela [Zamówienia])
--f) Za pomocą SOLUTION MANAGER > CONNECTION MANAGERS > NEW CONNECTION MANAGER stworzyć połączenie do pliku Excela, z którego będziemy importować dane do tabeli [Zamówienia]
--g) Stworzyć zadanie DATA FLOW TASK [Import danych z arkusza Excel] (pojawi się ono w zakładce DATA FLOW)
--h) Połączyć bloczki [Stworzenie tabeli Zamówienia w bazie BAZA]→[Import danych z arkusza Excel]
--i) Na karcie DATA FLOW zdefiniować i skonfigurować źródło danych typu Excel o nazwie [Tabela Zamówienia Arkusz] (bloczek EXCEL SOURCE). Uwaga: można zmienić nazwy kolumn docelowych. Zalecany podgląd i ew. ustalenie strategii usuwania błędnych danych (patrz następny punkt)
--j) Utworzyć bloczek typu CONDITIONAL SPLIT o nazwie [Rozdzielanie priorytetów] i połączyć źródło [Tabela Zamówienia Arkusz] z poprzedniego punktu z tym bloczkiem.
--k) Skonfigurować bloczek [Rozdzielanie priorytetów] tak, aby rozdzielał zamówienia o priorytecie "Low" (Strumień [Niski priorytet]) od pozostałych (Strumień [Normalny i wysoki priorytet])
--l) Dodać bloczek DATA CONVERSION o nazwie [Konwersja tekstu Unicode] i podłączyć go do strumienia [Normalny i wysoki priorytet] zmieniający typ unicode na string [DT_STR]
--m) Dodać i skonfigurować bloczek OLE DB DESTINATION o nazwie [Tabela Zamówienia w bazie BAZA], skojarzony z tabelą [Zamówienia] utworzoną w bazie [BAZA]; następnie połączyć z nim bloczek [Konwersja tekstu Unicode] z poprzedniego punktu. Uwaga: w zakładce MAPPINGS zwrócić uwagę na wybór zmiennych o typie string zdefiniowanych w punkcie l)
--n) Wykonać bloczek [Import danych z arkusza Excel]

--4. W podobny sposób utworzyć i wypełnić w [BAZA] tabele [Zwroty] oraz [Użytkownicy]

CREATE TABLE [dbo].[Zwroty] (
	OrderID INT,
	Status VARCHAR(255),
	PRIMARY KEY (Status,OrderID),
	FOREIGN KEY (OrderID) REFERENCES Zamowienia(OrderID)
	)
	
CREATE TABLE [dbo].[Uzytkownicy] (
	Region VARCHAR(255),
	Manager VARCHAR(255),
	PRIMARY KEY (Region,Manager),
	FOREIGN KEY (Region) REFERENCES Zamowienia(Region)
	)