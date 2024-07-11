

/*
	Practica Base de datos 2, completada por: Luis Angel Cabrera 1-23-7048
	manejo de funciones de agregado y el JOIN
*/



/* 
1. Calcular el promedio de descuentos aplicados por cada cliente.  */

Use Northwind

SELECT 
/* seleccionamos el id del cliente y el promedio de los descuentos	*/
    o.CustomerID, 
    AVG(od.Discount) AS PromedioDescuento
FROM 
/* determinamos la tabla de donde sacaremos el customer id [Orders] y le asignamos de alias ' o '    */
    dbo.Orders o
/* se hace un join donde unimos la tabla Orders con Ordes Details para poder seleccionar los discount junto al customer id 
basandonos en el OrderID y le asignamos el alias ' od '                                                                 */
JOIN 
    dbo.[Order Details] od ON o.OrderID = od.OrderID
/* agrupamos por el customerID */
GROUP BY 
    o.CustomerID;


/* *********************************************************************************************************************************** */

/*
2. Obtener el número de pedidos realizados por cada país en cada año.*/

SELECT 
    ShipCountry,
    YEAR(OrderDate) AS OrderYear,
    COUNT(OrderID) AS Cantidad_Ordenes
FROM 
    dbo.Orders
GROUP BY 
    ShipCountry,
    YEAR(OrderDate)
ORDER BY 
    ShipCountry, 
    OrderYear;

/* *********************************************************************************************************************************** */

/*
3. Determinar el monto total de fletes pagados por cada proveedor. */

select	
	P.SupplierID,
	sum(O.Freight) as totalFletePagado
from 
	dbo.Products P
join 
	dbo.[Order Details] OD 
ON 
	P.ProductID = OD.ProductID
join 
	dbo.Orders O
ON 
	OD.OrderID = O.OrderID
group by SupplierID


/* *********************************************************************************************************************************** */

/*
4. Calcular el promedio de días de entrega por cada región. */


select 
	ShipRegion,	
	/* aqui usamos la funcion DATEDIFF para calcular los dias entre la fecha de pedido y la fecha de entrega y el avg para el promedio de dias */
	AVG(DATEDIFF(day,OrderDate,ShippedDate)) as PromedioDiasEntrega
from Orders
group by ShipRegion


/* *********************************************************************************************************************************** */


/*
5. Encontrar el total de ingresos por cada categoría de producto. */


select 
	CategoryID,
	sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as IngresoTotal
from Products p
join 
	dbo.[Order Details] od
ON
	p.ProductID = od.ProductID
group by CategoryID





/* *********************************************************************************************************************************** */



/*
6. Obtener el número de productos diferentes vendidos por cada cliente. */

select 
	o.CustomerID,
	count(distinct od.ProductID) as NumeroProductoDiferente
from 
	Orders o
Join 
	dbo.[Order Details] od 
ON 
	od.OrderID = o.OrderID
group by
	o.CustomerID


/* *********************************************************************************************************************************** */


/*
7. Calcular el monto total de ventas por cada año. */


select
	YEAR(o.OrderDate) as Año,
	Count(od.OrderID) as VentasTotales
	
from 
	Orders o
Join
	dbo.[Order Details] od 
ON
	o.OrderID = od.OrderID 
group by 
	Year(O.OrderDate)
	


/* *********************************************************************************************************************************** */


/*
8. Determinar el número de pedidos realizados en cada país.*/

select 
	ShipCountry,
	count(OrderID) as Pedidos
from Orders
Group by ShipCountry



/* *********************************************************************************************************************************** */

/*

9. Encontrar el promedio de días entre la orden y el envío por cada proveedor. */

SELECT 
    p.SupplierID,
    AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS PromedioDias
FROM 
    dbo.Orders o
JOIN 
    dbo.[Order Details] od 
ON
    o.OrderID = od.OrderID
JOIN 
    dbo.Products p
ON  
    od.ProductID = p.ProductID
GROUP BY 
    p.SupplierID;


/* *********************************************************************************************************************************** */

/*
10. Calcular el total de ingresos por cada región.	*/



select 
	o.ShipRegion,
	sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as IngresoTotal
from dbo.Orders o
join 
	dbo.[Order Details] od
	
ON
	od.orderID = o.OrderID 
group by 
	o.ShipRegion

