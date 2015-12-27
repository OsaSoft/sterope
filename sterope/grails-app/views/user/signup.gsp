<%@ page import="cz.cvut.fel.hernaosc.via.sterope.user.User" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="create-user" class="content scaffold-create" role="main">
			<h1><g:message code="signup.title" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${userInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${userInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:userInstance, action:'register']" >
				<fieldset class="form">
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
						<label for="username">
							<g:message code="user.username.label" default="Username" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="username" required="" value="${userInstance?.username}"/>
					
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
						<label for="password">
							<g:message code="user.password.label" default="Password" />
							<span class="required-indicator">*</span>
						</label>
						<g:field type="password" name="password" required="" value="${userInstance?.password}"/>
					
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'firstname', 'error')} ">
						<label for="firstname">
							<g:message code="user.firstname.label" default="Firstname" />
							
						</label>
						<g:textField name="firstname" value="${userInstance?.firstname}"/>
					
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastname', 'error')} ">
						<label for="lastname">
							<g:message code="user.lastname.label" default="Lastname" />
							
						</label>
						<g:textField name="lastname" value="${userInstance?.lastname}"/>
					
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} ">
						<label for="email">
							<g:message code="user.email.label" default="Email" />
							
						</label>
						<g:field type="email" name="email" value="${userInstance?.email}"/>
					
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
