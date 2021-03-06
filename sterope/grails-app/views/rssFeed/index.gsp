
<%@ page import="cz.cvut.fel.hernaosc.via.sterope.feed.RssFeed" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'rssFeed.label', default: 'RssFeed')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-rssFeed" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-rssFeed" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'rssFeed.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="url" title="${message(code: 'rssFeed.url.label', default: 'Url')}" />
					
						<th><g:message code="rssFeed.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${rssFeedInstanceList}" status="i" var="rssFeedInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${rssFeedInstance.id}">${fieldValue(bean: rssFeedInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: rssFeedInstance, field: "url")}</td>
					
						<td>${fieldValue(bean: rssFeedInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${rssFeedInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
