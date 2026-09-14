CREATE DATABASE CrudProductosDb;
GO

USE CrudProductosDb;
GO

CREATE TABLE Productos
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);
GO

INSERT INTO Productos (Nombre, Precio, Stock)
VALUES
    (N'Teclado mecánico', 1299.90, 10),
    (N'Mouse inalámbrico', 549.50, 25),
    (N'Monitor 24 pulgadas', 3299.00, 7);
GO

SELECT * FROM Productos;
GO
