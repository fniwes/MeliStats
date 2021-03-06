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
						<sec:ifNotLoggedIn>
							<div class="btn-group">
								<a type="button" class="btn btn-danger navbar-btn" aria-expanded="false" href="${createLink(controller:'registrar', action:'index')}">Registrarse</a>
							</div>
							<div class="btn-group">
								<a class="btn btn-danger navbar-btn" aria-expanded="false"href="${createLink(controller:'login',action:'auth') }">Login</a>
							</div>

						</sec:ifNotLoggedIn>	
						<sec:ifLoggedIn>
							<div class="btn-group">
								<a class="btn btn-danger navbar-btn" aria-expanded="false"href="${createLink(controller:'miPerfil', action:'index') }">Mi perfil</a>
							</div>
							<div class="btn-group">
								<button type="button" class="btn btn-danger navbar-btn dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Vender <span class="caret"></span></button>
								<ul class="dropdown-menu" role="menu">
									<li><a href="${createLink(controller:'vender',action:'index') }">Sugerencias</a></li>
								</ul>
							</div>
							<div class="btn-group">
								<button type="button" class="btn btn-danger navbar-btn dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Comprar <span class="caret"></span></button>
								<ul class="dropdown-menu" role="menu">
									<li><a href="${createLink(controller:'busqueda', action: 'index')}">Recomendaciones</a></li>
								</ul>
							</div>
							<a type="button" class="btn btn-danger navbar-btn" aria-expanded="false" href="${createLink(controller:'logout') }">Logout</a>
						</sec:ifLoggedIn>	
					</ul>
				</div>
			</div>
		</nav>
		<g:layoutBody/>
	</body>
</html>