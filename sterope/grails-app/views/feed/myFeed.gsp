<div>
	<p>
		<g:if test="${numNewItems <= 0}">
			<g:message code="feed.noNew"/>
		</g:if>
		<g:else>
			<g:message code="feed.unread" args="[numNewItems]" />
			<div class="feed">
				<g:each in="${feed}" var="feedInstance">
					<h1>${feedInstance.title}</h1>
					<ul class="ulFeed">
						<g:each in="${feedInstance.items}" var="item">
							<li>${item.title}</li>
						</g:each>
					</ul>
				</g:each>
			</div>
		</g:else>
	</p>
</div>