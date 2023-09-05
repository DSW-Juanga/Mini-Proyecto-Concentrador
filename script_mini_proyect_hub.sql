

CREATE DATABASE " Mini-Project Hub"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;




CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    SKU VARCHAR(50)
);

CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(15),
    StreetAddress TEXT,
    PostalCode VARCHAR(10),
    Neighborhood VARCHAR(255)
);

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    SaleDate DATE
);

CREATE TABLE SaleDetails (
    SaleDetailID SERIAL PRIMARY KEY,
    SaleID INT REFERENCES Sales(SaleID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT
);

CREATE TABLE Cities (
    CityID SERIAL PRIMARY KEY,
    CityName VARCHAR(255)
);

INSERT INTO Customers (FirstName, LastName, Email, Phone, StreetAddress, PostalCode, Neighborhood) 
values ('jhon','doe ','john.doe@gmail.com','123-456-7890','125 Main St','14345','Hillside'),
 ('alska','dennis','alska.doe@ibm.com','123-456-7800','125 sain St','123445','Downtown'),
 ('juan','rodriguez','juan.rodriguez@IQ.com','123-456-7811','126 Main St','12225','Hillside'),
 ('maria ','vicentes','john.doe@gmail.com','123-456-7893','127 sain St','12545','Suburbia'),
 ('jenifer','lorenz','jenifer.loe@example.com','123-456-7822','128 Main St','14445','Hillside'),
 ('lorenzo ','dimarco','lorenzo.marco@hotmail.com','123-456-7845','129 Main St','10345','Downtown'),
 ('alexis','andresw','alexis.andresw@ibm.com','123-456-7866','130 sain St','12355','Hillside'),
('jada','stivens','jaada.sti@live.com','123-456-7877','131 Main St','10045','Hillside'),
 ('mia ','cowell','mia.cow@yahoo.com','123-456-7878','132 sain St','11145','Downtown'),
 ('bruce','pulishis','bruce.pilsh@icloud.com','123-456-7899','133 Main St','22245','Hillside'),
('michaeL','janes ','michaeL.janes@live.com','123-456-7901','134 sain St','13345','Suburbia'),
 ('wilson','rodriguez','wilson.rod@gmail.com','123-456-9999','135 sain St','77745','Suburbia'),
 ('amanda','colins','amanda.co@hotmail.com','123-456-7777','135 sain St','77745','Suburbia');
 
 select * from Customers
 
 
 
 
 INSERT INTO Cities (CityName) VALUES
    ('Monterrey'),
    ('Guadalajara'),
    ('Cancun'),
	('Bogota'),
    ('CALI'),
    ('atlanta'),
	('rio'),
    ('medellin'),
    ('barranquilla'),
	('meta'),
    ('orlando'),
    ('washington');
	
	
	INSERT INTO Sales (CustomerID, SaleDate) VALUES
    (1, '2023-01-15'),
    (2, '2023-02-20'),
    (3, '2023-03-25'),
	(4, '2023-04-10'),
    (5, '2023-05-26'),
    (6, '2023-07-08'),
	(7, '2023-08-10'),
    (8, '2023-09-20'),
    (9, '2023-10-22'),
	(10, '2023-11-11'),
    (11, '2023-12-20'),
    (12, '2024-01-23'),
	(13, '2024-02-16');
	
	
	---select * from products


INSERT INTO Products (Name, Description, Price, SKU) VALUES
    ('Product A', 'Description A', 10.99, 'SKU001'),
    ('Product B', 'Description B', 15.99, 'SKU002'),
    ('Product C', 'Description C', 5.99, 'SKU003'),
	('Product D', 'Description A', 11.99, 'SKU004'),
    ('Product E', 'Description B', 20.99, 'SKU005'),
    ('Product F', 'Description C', 30.99, 'SKU006'),
	('Product G', 'Description A', 40.99, 'SKU007'),
    ('Product H', 'Description B', 25.99, 'SKU008'),
    ('Product I', 'Description C', 7.99, 'SKU009');
	('Product J', 'Description A', 12.99, 'SKU010'),
    ('Product K', 'Description B', 17.99, 'SKU012'),
    ('Product M', 'Description C', 55.99, 'SKU013');




	
	INSERT INTO SaleDetails (SaleID, ProductID, Quantity) VALUES
    (15, 1, 5),
    (16, 2, 3),
    (17, 3, 2),
    (18, 4, 10),
	(19, 5, 5),
    (20, 6, 3),
    (21, 7, 2),
    (18, 8, 10)
	(22, 9, 5),
    (16, 10, 3),
    (17, 11, 2),
    (22, 12, 10),
	(23, 11, 5),
    (24, 10, 3),
    (25, 11, 2),
    (26, 8, 10),
	(27, 9, 15),
    (23, 10, 13),
    (23, 11, 12),
    (22, 12, 10);
	

--1.ID de los clientes de la Ciudad de Monterrey

SELECT CustomerID
FROM Customers
WHERE Neighborhood = 'Monterrey';

--2. ID y descripción de los productos que cuesten menos de 15 pesos

SELECT ProductID, Description
FROM Products
WHERE Price < 15.00;

--3. ID y nombre de los clientes, cantidad vendida, y descripción del producto, en las ventas en las cuales se vendieron más de 10 unidades.

SELECT C.CustomerID, C.FirstName, C.LastName, SD.Quantity, P.Description
FROM Customers C
JOIN Sales S ON C.CustomerID = S.CustomerID
JOIN SaleDetails SD ON S.SaleID = SD.SaleID
JOIN Products P ON SD.ProductID = P.ProductID
WHERE SD.Quantity > 10;

--4. ID y nombre de los clientes que no aparecen en la tabla de ventas (Clientes que no han comprado productos)

SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
LEFT JOIN Sales S ON C.CustomerID = S.CustomerID
WHERE S.SaleID IS NULL;



--5. ID y nombre de los clientes que han comprado todos los productos de la empresa.

SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
WHERE NOT EXISTS (
    SELECT P.ProductID
    FROM Products P
    WHERE NOT EXISTS (
        SELECT SD.ProductID
        FROM SaleDetails SD
        JOIN Sales S ON SD.SaleID = S.SaleID
        WHERE S.CustomerID = C.CustomerID AND SD.ProductID = P.ProductID
    )
);


--6. ID y nombre de cada cliente y la suma total (suma de cantidad) de los productos que ha comprado. 


SELECT C.CustomerID, C.FirstName, C.LastName, SUM(SD.Quantity) AS TotalQuantity
FROM Customers C
LEFT JOIN Sales S ON C.CustomerID = S.CustomerID
LEFT JOIN SaleDetails SD ON S.SaleID = SD.SaleID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

--7--ID de los productos que no han sido comprados por clientes de Guadalajara.

SELECT P.ProductID
FROM Products P
WHERE NOT EXISTS (
    SELECT S.SaleID
    FROM Sales S
    JOIN Customers C ON S.CustomerID = C.CustomerID
    JOIN Cities CI ON C.Neighborhood = CI.CityName
    WHERE CI.CityName = 'Guadalajara'
    AND EXISTS (
        SELECT SD.ProductID
        FROM SaleDetails SD
        WHERE SD.ProductID = P.ProductID
        AND SD.SaleID = S.SaleID
    )
);

--8. ID de los productos que se han vendido a clientes de Monterrey y que también se han vendido a clientes de Cancún.
SELECT P.ProductID
FROM Products P
WHERE EXISTS (
    SELECT S1.SaleID
    FROM Sales S1
    JOIN Customers C1 ON S1.CustomerID = C1.CustomerID
    JOIN Cities CI1 ON C1.Neighborhood = CI1.CityName
    WHERE CI1.CityName = 'Monterrey'
    AND EXISTS (
        SELECT SD1.ProductID
        FROM SaleDetails SD1
        WHERE SD1.ProductID = P.ProductID
        AND SD1.SaleID = S1.SaleID
    )
) AND EXISTS (
    SELECT S2.SaleID
    FROM Sales S2
    JOIN Customers C2 ON S2.CustomerID = C2.CustomerID
    JOIN Cities CI2 ON C2.Neighborhood = CI2.CityName
    WHERE CI2.CityName = 'Cancun'
    AND EXISTS (
        SELECT SD2.ProductID
        FROM SaleDetails SD2
        WHERE SD2.ProductID = P.ProductID
        AND SD2.SaleID = S2.SaleID
    )
);

--9.Nombre de las ciudades en las que se han vendido todos los productos.





SELECT CI.CityName
FROM Cities CI
WHERE NOT EXISTS (
    SELECT P.ProductID
    FROM Products P
    WHERE NOT EXISTS (
        SELECT SD.ProductID
        FROM SaleDetails SD
        JOIN Sales S ON SD.SaleID = S.SaleID
        JOIN Customers C ON S.CustomerID = C.CustomerID
        WHERE C.Neighborhood = CI.CityName
        AND SD.ProductID = P.ProductID
    )
);
















































































