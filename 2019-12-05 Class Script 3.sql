CREATE TABLE Examples.GadgetType
(
	GadgetType varchar(10) NOT NULL CONSTRAINT PKGadgetType
	PRIMARY KEY,
	Description varchar(200) NOT NULL
)
INSERT INTO Examples.GadgetType(GadgetType, Description)
VALUES ('Manual','No Batteries'),
		('Electronic','Lots of bats');

ALTER TABLE Examples.Gadget
	ADD CONSTRAINT FKGadget$ref$Examples_GadgetType
		FOREIGN KEY (GadgetType) REFERENCES Examples.GadgetType
		(GadgetType);

CREATE VIEW Examples.GadgetExtension
AS
	SELECT Gadget.GadgetID, Gadget.GadgetNumber,
	Gadget.GadgetType, GadgetType.GadgetType AS
	DomainGadgetType,
	GadgetType.Description AS GadgetTypeDescription
FROM Examples.Gadget
	JOIN Examples.GadgetType
	ON Gadget.GadgetType = GadGetType.GadgetType;


INSERT INTO Examples.GadgetExtension(GadgetId, GadgetNumber, GadgetType, DomainGadgetType, GadgetTypeDescription)
VALUES (7,'00000007','Acoustic','Acoustic','Sound');

INSERT INTO Examples.GadgetExtension(GadgetId, GadgetNumber, GadgetType)
VALUE(7,'00000007','Acoustic');

UPDATE Examples.GadgetExpension 
SET GadgetTypeDescripton = 'Uses Batteries'
WHERE GadgetID = 1;
GO

CREATE TABLE Examples.Invoices_Region1
(
	InvoiceId int NOT NULL
		CONSTRAINT PKInvoices_Regional1 PRIMARY KEY,
		CONSTRAINT CHKInvoices_region1_PartKey
		CHECK (InvoiceId BETWEEN 1 and 10000),
		
		CustomerId int NOT NULL,
		InvoiceDate date NOT NULL
	);
	CREATE TABLE Examples.Invoices_Region2
	( 
		InvoiceId int NOT NULL
			CONSTRAINT PKInvoices_Region2 PRIMARY KEY,
			CONSTRAINT CHKInvoices_Region2_PartKey
			CHECK (InvoiceId BETWEEN 10001 and 20000),
			CustomerId int NOT NULL,
			InvoiceDate date NOT NULL);

INSERT INTO Examples.Invoices_Region1
(InvoiceId, CustomerId, InvoiceDate)
	SELECT InvoiceId, CustomerId, InvoiceDate
	FROM WideWorldImporters.Sales.Invoices
	WHERE InvoiceId BETWEEN 1 and 10000;

	INSERT INTO Examples.Invoice_Region2
	(InvoiceID, CustomerId, InvoiceDate)
	SELECT InvoiceId, CustomerId, InvoiceDate
	FROM WideWorldImporters.Sales.Invoices
	WHERE InvoiceId BETWEEN 10001 AND 20000;


CREATE VIEW Examples.InvoicesPartitioned
AS
	SELECT InvoiceId, CustomerId, InvoiceDate
	FROM Examples.Invoices_Region1
	UNION ALL
	SELECT InvoiceId, CustomerId, InvoiceDate
	FROM Examples.Invoices_Region2;

SELECT * 
FROM Examples.InvoicesPartitioned
WHERE InvoiceId = 1;

SELECT InvoiceId
From Examples.InvoicePartitioned
WHERE IvoiceDate = '2013-01-01';


SELECT InvoiceId, CustomerId, InvoiceDate
FROM Sales.Invoices_Region1
UNION ALL
SELECT InvoiceId, CustomerId, InvoiceDate
FROM ServerName.DatabaseName.Sales.Invoices_Region1;

CREATE VIEW Sales.InvoiceCustomerInvoiceAggregates
WITH SCHEMABINDING
AS
SELECT Invoices.CustomerId,
	SUM(ExtendedPrice * Quantity) AS SumCost,
	SUM(LineProfit) AS SumProfit,
	COUNT_BIG(*) AS TotalItemCount
FROM Sales.Invoices
	JOIN Sales.InvoiceLines
	ON Invoices.InvoiceId = InvoiceLines.InvoiceId
GROUP BY Invoices.CustomerId;

CREATE UNIQUE CLUSTERED INDEX XPKInvoiceCustomerInvoiceAggregates on
Sales.InvoiceCustomerInvoiceAggregates(CustomerID);