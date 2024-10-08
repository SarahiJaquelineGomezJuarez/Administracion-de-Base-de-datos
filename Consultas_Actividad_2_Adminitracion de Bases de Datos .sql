-------------------------Consultas---------------------
-----------------1=La cantidad de clientes en el año 2021-------
USE AkirasBoutiques;
GO
SELECT COUNT(DISTINCT id_cliente) AS Cantidad_Clientes_2021
FROM factura
WHERE YEAR(fecha) = 2021;
GO
-------------------------2=La cantidad de clientes en lo que va del año 2022.-------------
USE AkirasBoutiques;
GO
SELECT COUNT(DISTINCT id_cliente) AS Cantidad_Clientes_2022
FROM factura
WHERE YEAR(fecha) = 2022;
GO
---------------------------------3=Los clientes que tuvieron en diciembre de 2021--------                                    
USE AkirasBoutiques;
GO
SELECT nombre, email, fecha
FROM Cliente
JOIN factura ON cliente.id_cliente = factura.id_cliente
WHERE YEAR(fecha) = 2021;
GO
-----------------------------------4= ¿Qué compras han realizado algunos clientes en específico?-/CAMBIO DE DATO TEXT a Varchar-----
USE AkirasBoutiques;
GO
USE AkirasBoutiques;
GO
SELECT CAST(c.nombre AS VARCHAR(255)) AS Nombre, 
       CAST(c.apellido AS VARCHAR(255)) AS Apellido, 
       p.nombre AS Producto, 
       d.cantidad, 
       d.precio
FROM cliente c
INNER JOIN factura f ON c.id_cliente = f.id_cliente
INNER JOIN detalle d ON f.id_detalle = d.id_detalle
INNER JOIN producto p ON d.id_producto = p.id_producto
WHERE CAST(c.nombre AS VARCHAR(255)) IN ('Valentina Anastasia', 'Zayra Manuela', 'Dante Eduardo', 'Ana Maribel', 'Rodrigo Ismael')
  AND CAST(c.apellido AS VARCHAR(255)) IN ('Huerta Corral', 'Gómez López', 'Dolores Meza', 'Cedillo Núñez', 'Silva Ugarte');
GO
USE AkirasBoutiques;
GO
SELECT CONVERT(VARCHAR(255), c.nombre) AS Nombre, 
       CONVERT(VARCHAR(255), c.apellido) AS Apellido, 
       p.nombre AS Producto, 
       d.cantidad, 
       d.precio
FROM cliente c
INNER JOIN factura f ON c.id_cliente = f.id_cliente
INNER JOIN detalle d ON f.id_detalle = d.id_detalle
INNER JOIN producto p ON d.id_producto = p.id_producto
WHERE CONVERT(VARCHAR(255), c.nombre) IN ('Valentina Anastasia', 'Zayra Manuela', 'Dante Eduardo', 'Ana Maribel', 'Rodrigo Ismael')
  AND CONVERT(VARCHAR(255), c.apellido) IN ('Huerta Corral', 'Gómez López', 'Dolores Meza', 'Cedillo Núñez', 'Silva Ugarte');
GO
  -------------------------------------------5= ¿Qué producto es el que más ventas ha tenido?---------------------------
 
USE AkirasBoutiques;----Cambio de tipo de Dato de TEXT a Varchar---------
GO
SELECT TOP 1 
    CAST(p.nombre AS VARCHAR(255)) AS Producto, 
    SUM(d.cantidad) AS Total_Ventas
FROM producto p
INNER JOIN detalle d ON p.id_producto = d.id_producto
GROUP BY CAST(p.nombre AS VARCHAR(255))
ORDER BY Total_Ventas DESC;
GO
USE AkirasBoutiques;-----funcion de Convert----------------
GO
SELECT TOP 1 
    CONVERT(VARCHAR(255), p.nombre) AS Producto, 
    SUM(d.cantidad) AS Total_Ventas
FROM producto p
INNER JOIN detalle d ON p.id_producto = d.id_producto
GROUP BY CONVERT(VARCHAR(255), p.nombre)
ORDER BY Total_Ventas DESC;
GO
--------------------------------------------6=¿Qué producto tiene más cantidad en stock?---------------------------------------
USE AkirasBoutiques;
GO
SELECT TOP 1 nombre AS Producto, stock
FROM producto
ORDER BY stock DESC;
GO
----------------------------------------7= Ordenar por fecha las compras que ha habido en la tienda.---------------------------
USE AkirasBoutiques;
GO
SELECT f.id_factura, f.fecha, c.nombre AS Cliente, p.nombre AS Producto, d.cantidad, d.precio
FROM factura f
INNER JOIN cliente c ON f.id_cliente = c.id_cliente
INNER JOIN detalle d ON f.id_detalle = d.id_detalle
INNER JOIN producto p ON d.id_producto = p.id_producto
ORDER BY f.fecha ASC;
GO
---------------------------------------------8= Ordenar alfabéticamente los nombres de los clientes de la tienda.----------------------
USE AkirasBoutiques;
GO
SELECT CAST(nombre AS VARCHAR(MAX)) AS nombre_cliente
FROM Cliente
ORDER BY nombre_cliente ASC;
GO
---------------------9= Seleccionar cuántos productos hay en cada categoría: falda, pantalón, chamarra,zapatos y accesorios.-----------------
USE AkirasBoutiques;
GO
SELECT Producto.nombre, Categoria.nombre AS categoria_nombre
FROM Producto
JOIN Categoria ON Producto.id_categoria = Categoria.id_categoria;
GO
------------------------------------------------10= ¿Cuáles son los encargados en cada sucursal de Akira's Boutique?--------------
USE AkirasBoutiques;
GO
SELECT Nombre_Sucursal, Encargado_Sucursal
FROM Sucursales;
GO
----------------------------11= ¿Cuáles son los empleados que trabajan en la sucursal de Akira's Boutique sucursal Constitucion-----
USE AkirasBoutiques;
GO
SELECT e.Nombre
FROM Empleados e
INNER JOIN Sucursales s ON e.ID_Sucursal = s.ID_Sucursal
WHERE s.Nombre_Sucursal = 'Akira''s Boutique: Constitución';
GO
-----------------------------------------12= ¿Cuáles clientes son mayores de 30 años?----------------------------------
USE AkirasBoutiques;
GO
SELECT nombre, apellido, DATEDIFF(YEAR, fec_nac, GETDATE()) AS Edad
FROM cliente
WHERE DATEDIFF(YEAR, fec_nac, GETDATE()) > 30;
GO
------------------------------------13=Seleccionar los clientes del año 2021 en base a la fecha de la factura--------------
USE AkirasBoutiques;
GO
SELECT nombre, email, fecha
FROM Cliente
JOIN factura ON cliente.id_cliente = factura.id_cliente
WHERE YEAR(fecha) = 2021;
GO
--------------------------14= Seleccionar los clientes de 2022 (hasta el momento) en base a la fecha de la Factura----------
USE AkirasBoutiques;
GO
SELECT nombre, email, fecha
FROM Cliente
JOIN Factura ON Cliente.id_cliente = Factura.id_cliente
WHERE fecha >= '2022-01-01' AND fecha <= GETDATE();
GO
------------------------------------15. Seleccionar los clientes de diciembre de 2021----------------------------------------
USE AkirasBoutiques;
GO
SELECT nombre, email, fecha
FROM Cliente
JOIN Factura ON Cliente.id_cliente = Factura.id_cliente
WHERE YEAR(fecha) = 2021 AND MONTH(fecha) = 12;
GO
---------------------------------16. ¿Qué compras han realizado los siguientes clientes? (Detalles especificados)-------------
USE AkirasBoutiques;
GO
SELECT Factura.id_factura, Cliente.nombre, Producto.nombre, Factura.fecha
FROM Cliente
JOIN Factura ON Cliente.id_cliente = Factura.id_cliente
JOIN Producto ON Factura.id_detalle = Producto.id_producto -- Cambia id_detalle si es incorrecto
WHERE CAST(Cliente.nombre AS VARCHAR(MAX)) IN ('Valentina Anastasia',
 'Zayra Manuela ',
 'Dante Eduardo ',
 'Ana Maribel ',
 'Rodrigo Ismael');
GO
-----------------------------------------------17. Seleccionar el producto que más ventas ha tenido------------------------------
USE AkirasBoutiques;
GO
SELECT TOP 1 CAST(Producto.nombre AS VARCHAR(MAX)) AS nombre_producto,
COUNT(Factura.id_detalle) AS total_ventas
FROM Producto
JOIN Factura ON Producto.id_producto = Factura.id_cliente -- Asegúrate de que esta columna es correcta
GROUP BY CAST(Producto.nombre AS VARCHAR(MAX))
ORDER BY total_ventas DESC;
GO
----------------------------------18. ¿Qué producto tiene más cantidad en stock?--------------------------------------
USE AkirasBoutiques;
GO
SELECT TOP 1 nombre AS Producto, stock
FROM producto
ORDER BY stock DESC;
GO
------------------------------------19. Ordenar, de la más antigua a la más reciente, las compras que ha habido en la tienda---------
USE AkirasBoutiques;
GO
SELECT f.id_factura, f.fecha, c.nombre AS Cliente, p.nombre AS Producto, d.cantidad, d.precio
FROM factura f
INNER JOIN cliente c ON f.id_cliente = c.id_cliente
INNER JOIN detalle d ON f.id_detalle = d.id_detalle
INNER JOIN producto p ON d.id_producto = p.id_producto
ORDER BY f.fecha ASC;
GO
----------------------------------20. Ordenar alfabéticamente los nombres de todos los clientes de la tienda----------------
USE AkirasBoutiques;
GO
SELECT id_factura, fecha
FROM Factura
ORDER BY fecha ASC;
GO
----------------------------21. Seleccionar cuáles productos pertenecen a cada categoría---------------------------------------
USE AkirasBoutiques;
GO
USE AkirasBoutiques;
GO
SELECT CAST(c.nombre AS VARCHAR(255)) AS Categoria, p.nombre AS Producto
FROM categoria c
INNER JOIN producto p ON c.id_categoria = p.id_categoria
WHERE CAST(c.nombre AS VARCHAR(255)) IN ('Falda', 'Pantalon', 'Chamarra', 'Zapatos', 'Accesorios');
GO
---------------------------22. Seleccionar los encargados de las sucursales de la tienda Akira’s Boutique--------------------------
USE AkirasBoutiques;
GO
SELECT Nombre_Sucursal, Encargado_Sucursal
FROM Sucursales;
GO
-------------------------------------23. Seleccionar los empleados que trabajan en la sucursal de Akira’s Boutique: Constitución-------------
USE AkirasBoutiques;
GO
SELECT e.Nombre
FROM Empleados e
INNER JOIN Sucursales s ON e.ID_Sucursal = s.ID_Sucursal
WHERE s.Nombre_Sucursal = 'Akira''s Boutique: Constitución';
GO
---------------------------24. ¿Qué clientes son mayores de 30 años?----------------------------------------------------------------
USE AkirasBoutiques;
GO
SELECT nombre, apellido, DATEDIFF(YEAR, fec_nac, GETDATE()) AS Edad
FROM cliente
WHERE DATEDIFF(YEAR, fec_nac, GETDATE()) > 30;
GO