use [back of house]
--
create view vwGrilla
as
select *
from grilla
--
create view vwPedidos
as
select
		pedidos.id,
		pedidos.cuitProveedor,
		pedidos.fechaInicio,
		isnull(productosXpedidos.cantidad,0) as 'cant pedido'
from pedidos
inner join productosXpedidos on pedidos.id=productosXpedidos.idPedido
where pedidos.entregado=0 or pedidos.entregado is null 
--
create view vwPedidosEntregados
as
select
		pedidos.id,
		pedidos.cuitProveedor,
		pedidos.fechaInicio,
		isnull(productosXpedidos.cantidad,0) as 'cant pedido'
from pedidos
inner join productosXpedidos on pedidos.id=productosXpedidos.idPedido
where pedidos.entregado=1
--
create view vwProductoMasVendido
as
select top 1 with ties
		productos.upc,
		productos.descripcion,
		ISNULL(SUM(productosXventa.cantidad), 0) as 'cant vendida'
from productosXventa
inner join productos on productosXventa.upc=productos.upc
group by productos.upc, productos.descripcion
order by [cant vendida] desc
--
create view vwProductosStockmin
as
select *
from productos
where productos.stock<=productos.stockMin
--
create view vwCantXprecio
as
select
		productosXventa.idVenta,
		productosXventa.cantidad*productosXventa.precioUnitario as 'p1'
from productosXventa

create view vwVentasMontoTotal
as
select
		ventas.id,
		ventas.fecha,
		ventas.legajoVendedor,
		ISNULL(sum(vwCantXprecio.p1), 0) as 'monto total'
from ventas
inner join vwCantXprecio on ventas.id=vwCantXprecio.idVenta
group by ventas.id, ventas.fecha, ventas.legajoVendedor

select * from vwVentasMontoTotal
