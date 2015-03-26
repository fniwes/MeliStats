<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<meta name="layout" content="_layout" />
</head>
<body>
	<g:hiddenField id="offset" name="offset" value="0" />
	<g:hiddenField id="maxRows" name="maxRows" value="0" />
	<div style="position: relative; top: 50px; left: 0px">
		<section class="panel panel-primary">
			<header>
				<h2>¿Que desea vender?</h2>
			</header>
			<p>recomendaciones para la venta de ...</p>
		</section>
		<article>
			<section style="float: left; width: 65%; border: 0px solid">
				<div class="row">
					<div class="col-lg-6">
						<div class="input-group">
							<input type="text" class="form-control" id="textBusqueda" placeholder="sugerencias para:">
							<span class="input-group-btn">
								<button class="btn btn-default" id="botonBuscador" type="button">Buscar</button>
							</span>
						</div>
					</div>
				</div>
				<div  class="well well-sm" id="listado-resultado">
				</div>
			</section>
			<aside
				style="font-style: arial; float: right; width: 34%; border: 0px solid">
				<h4> Posibles compradores</h4>	
				<p style="height:415px">
					<g:each in="${listaEmpleados}" var="unEmpleado">
						<ul style="width: 250px; margin-top: -130px;">
							<li>
								${unEmpleado}
								<button class="btn btn-default" type="button">Contactar</button>
							</li>
						</ul>
					</g:each>
				</p>
			</aside>
		</article>
	</div>
	<script type="text/javascript">
		/*la funcion calcular retorna una promesa, para ello se crea una variable global llamada deferred
		de tipo $.Deferred(), se necesito esto para que la suma total se agrege al contenido_tabla una vez 
		que termino la ULTIMA LLAMADA DE AJAX a la api de mercado libre para calcular la suma total de precios
		del conjunto de items correspondientes a una busquedea*/

		var deferred
		var sumaTotal = 0
		var cantidadItems = 0
		var cantidadItemsConMP = 0
		var cantidadItemsVendidos = 0
		var cantidadItemsVendidosConMP = 0
		var cantidadItemsConME = 0
		var cantidadItemsVendidosConME = 0
		$("#listado-resultado").hide()
		$("#botonBuscador").click(accionBuscar)
		$("#textBusqueda").keypress(verificarEnter)
		
		function accionBuscar() {
			$("#listado-resultado").show()
			deferred = $.Deferred()
			var tabla = document.getElementById("listado-resultado")
			while (tabla.firstChild) {
				tabla.removeChild(tabla.firstChild)
				sumaTotal = 0
				cantidadItems = 0
			}
			calcular(0).done(
					function() {
						console.log(sumaTotal)
						console.log("la cantidad de items procesados es :"+cantidadItems)
						console.log("items con MP "+cantidadItemsConMP)
						console.log("cant items "+cantidadItems)
						console.log("cant items vendidos con mp "+cantidadItemsVendidosConMP)
						console.log("cant items vendidos "+cantidadItemsVendidos)
						var montoPromedio = ""
						var porcentajeArticulosConMp = ""
						var porcentajeDeVentasConMp = ""
						var porcentajeDeVentasConMe = ""
						montoPromedio += "<div align=center><h3>" + "Precio sugerido: $"
								+ sumaTotal / cantidadItems + "</h3></div>"
						porcentajeArticulosConMp += "<h3>"
								+ "Porcentaje de articulos con MP: "
								+ cantidadItemsConMP / cantidadItems
								+ "</h3>"
						porcentajeDeVentasConMp += "<h3>"
								+ "Los articulos que usan MP representan : "
								+ cantidadItemsVendidosConMP
								/ cantidadItemsVendidos + "</h3>"
						porcentajeDeVentasConMe += "<h3>"
								+ "Los articulos que usan ME representan : "
								+ cantidadItemsVendidosConME
								/ cantidadItemsVendidos + "</h3>"
						$("#listado-resultado").append(montoPromedio)
						$("#listado-resultado").append(porcentajeArticulosConMp)
						$("#listado-resultado").append(porcentajeDeVentasConMp)
						$("#listado-resultado").append(porcentajeDeVentasConMe)
					});
		}
		
		function verificarEnter(event) {
			if (event.which == 13) {
				accionBuscar()
			}
		}
		
		//retorna false cuando se hizo la ultima llamada a la api de mercado libre
		function procesarEstadisticas(data) {
			console.log(data.paging)
			$.each(data.results, procesarItem)
			if (data.paging.offset + data.paging.limit < data.paging.total) {
				calcular(data.paging.offset + data.paging.limit)
				return true
			}
			return false
		}

		function calcular(offset) {
			var busqueda = $("#textBusqueda").val();
			var promise = $.get(
					"https://api.mercadolibre.com/sites/MLA/search", {
						q : busqueda,
						offset : offset,
						limit : 200
					});
			promise.done(function(data) {
				if (data.paging.total > 5000)
					alert("especifique mas la busqueda")
				var estadisticaTerminada = procesarEstadisticas(data)
				if (estadisticaTerminada == false)
					deferred.resolve() //si procesarEstadisticas devuelve false, la promesa se cumplio
			});
			promise.fail(mostrarError)
			return deferred.promise()
		}

		//los articulos que son subastas tienen una varianza en el precio muy grande con el promedio
		function procesarItem(index, item) {
			if (item.buying_mode == "buy_it_now"
					|| item.buying_mode == "classified") {
				cantidadItems += 1
				sumaTotal += item.price
				cantidadItemsVendidos += item.sold_quantity
				if (item.accepts_mercadopago) {
					cantidadItemsConMP++
					cantidadItemsVendidosConMP += item.sold_quantity
				}
				if (item.shipping.free_shipping) {
					cantidadItemsConME++
					cantidadItemsVendidosConME += item.sold_quantity
				}
			}
		}

		function mostrarError() {
			$("#respuesta_api").html("<li>Se produjo un errors</li>")
		}
	</script>
</body>
</html>