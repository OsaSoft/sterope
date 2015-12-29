
<%@ page import="cz.cvut.fel.hernaosc.via.sterope.user.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<sec:ifAnyGranted roles="ROLE_ADMIN">
					<li><a class="list" href="${createLink(controller: 'user')}"><g:message code="default.list.label" args="[entityName]"/></a></li>
				</sec:ifAnyGranted>
			</ul>
		</div>
		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="default.edit.label" args="[message(code:'user.username.label', default:'Username')]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
			<div class="errors" role="alert">${flash.error}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.username}">
				<li class="fieldcontain">
					<g:form controller="user" action="doEditUsername" method="POST">
						<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label">
							<g:textField name="newUsername" value="${userInstance.username}"/>
						</span>
						
						<span class="property-label"><g:submitButton name="submit" value="${message(code:'default.button.edit.label')}"/> </span>
					</g:form>
				</li>
				</g:if>
			</ol>
		</div>
	</body>
</html>
