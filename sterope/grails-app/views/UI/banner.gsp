<div style="text-align: right;">
	<sec:ifLoggedIn>
		<g:link uri="/profile">${user.firstname + " " + user.lastname} </g:link>
		<g:link controller="logout">Logout</g:link>
	</sec:ifLoggedIn>
	<sec:ifNotLoggedIn>
		<g:link controller="login">Login</g:link>
	</sec:ifNotLoggedIn>
</div>