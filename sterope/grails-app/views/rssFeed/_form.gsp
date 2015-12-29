<%@ page import="cz.cvut.fel.hernaosc.via.sterope.feed.RssFeed" %>



<div class="fieldcontain ${hasErrors(bean: rssFeedInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="rssFeed.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${rssFeedInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: rssFeedInstance, field: 'url', 'error')} required">
	<label for="url">
		<g:message code="rssFeed.url.label" default="Url" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="url" required="" value="${rssFeedInstance?.url}"/>

</div>