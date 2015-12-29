
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
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.success}">
			<div class="message" role="status">${flash.success}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label">
							<g:fieldValue bean="${userInstance}" field="username"/>
							<g:link controller="user" action="editUsername"><i class="fa fa-pencil-square-o"></i>&nbsp;<g:message code="default.button.edit.label"/></g:link>
						</span>
				</li>
				</g:if>
			
				<g:if test="${userInstance?.firstname}">
				<li class="fieldcontain">
					<span id="firstname-label" class="property-label"><g:message code="user.firstname.label" default="Firstname" /></span>
					
						<span class="property-value" aria-labelledby="firstname-label"><g:fieldValue bean="${userInstance}" field="firstname"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.lastname}">
				<li class="fieldcontain">
					<span id="lastname-label" class="property-label"><g:message code="user.lastname.label" default="Lastname" /></span>
					
						<span class="property-value" aria-labelledby="lastname-label"><g:fieldValue bean="${userInstance}" field="lastname"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="user.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="facebookUser-label" class="property-label"><g:message code="user.facebookUser.label" default="Facebook User" /></span>
					
						<span class="property-value" aria-labelledby="facebookUser-label">
							<g:if test="${userInstance?.facebookUser}">
							${userInstance.facebookUser.name}
							<g:link controller="user" action="unlinkFb"><i class="fa fa-unlink"></i>&nbsp;<g:message code="user.social.unlink"/></g:link>
							</g:if>
							<g:else>
								<facebookAuth:connect/>
							</g:else>
						</span>
					
				</li>
				
				<li class="fieldcontain">
					<span id="rssFeeds-label" class="property-label"><g:message code="user.rssFeeds.label" default="RSS Feeds" /></span>
					
					<g:each in="${userInstance.rssFeeds}" var="rss">
						<span class="property-value" aria-labelledby="rssFeeds-label">
							<g:link title="${rss.url}" controller="rssFeed" action="show" params="[id: rss.id]" >${rss.name}</g:link>
							<g:form style="display:inline;" id="delForm" url="[resource: rss, action:'delete']" method="DELETE">
								<a href="#" onclick="document.getElementById('delForm').submit();"><i class="fa fa-times-circle"></i>&nbsp;<g:message code='default.button.delete.label'/></a>
							</g:form>
						</span>
					</g:each>
					
					<span class="property-value" aria-labelledby="rssFeeds-label">
						<g:link controller="rssFeed" action="create"><i class="fa fa-plus-circle"></i>&nbsp;<g:message code="rssFeed.add.label"/></g:link>
					</span>
				</li>
			</ol>
		</div>
	</body>
</html>
