<div>
	<p>
		<g:if test="${feedItems.isEmpty()}">
			<g:message code="feed.noNew"/>
		</g:if>
		<g:else>
			<g:message code="feed.unread" args="[feedItems.size()]" />
		</g:else>
	</p>
</div>