<!DOCTYPE html>
<html>
	<head>
		<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
		<link rel="stylesheet" href="${resource(dir:'css', file: 'bootstrap.css')}" />
		<script type="text/javascript" src="${resource(dir:'js', file: 'bootstrap.js')}"></script>
		<g:layoutHead/>
	</head>
	<body style="background:rgba(255, 255, 255, 1)">
		<nav class="navbar navbar-fixed-top navbar-inverse">
			<div class="container">
				<div class="navbar-header">
          			<ul class="nav navbar-nav">
          				<li><a class="navbar-brand" href="${createLink(controller:'principal',action:'index') }">MeliStats</a></li>
          			</ul>
        		</div>
				<div id="navbar" class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-right">
						<a href="/MeliStats"><button type="button" class="btn btn-danger navbar-btn">Home</button></a>
						<div class="btn-group">
							<button type="button" class="btn btn-danger navbar-btn dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Vender <span class="caret"></span></button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="${createLink(controller:'busqueda',action:'index') }">Sugerencias</a></li>
							</ul>
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-danger navbar-btn dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Comprar <span class="caret"></span></button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="${createLink(controller:'vender', action: 'index')}">Recomendaciones</a></li>
								<li><a href="#">Mis Busquedas</a></li>
							</ul>
						</div>
					</ul>
				</div>
			</div>
		</nav>
		<g:layoutBody/>
	</body>
</html>