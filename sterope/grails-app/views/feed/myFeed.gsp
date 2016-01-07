<div>
	<p>
		<g:if test="${numNewItems <= 0}">
			<g:message code="feed.noNew"/>
		</g:if>
		<g:else>
			<g:message code="feed.unread" args="[numNewItems]" />
			<g:link controller="feed" action="markAllRead"><g:message code="feed.markAllRead"/></g:link>
			<div class="feed">
				<g:each in="${feed}" var="feedInstance">
					<ul class="ulFeed">
						<li>
							<h2>${feedInstance.feedName}</h2>
							
							<p class="timestamp"><g:formatDate date="${feedInstance.date}" format="HH:mm dd.MM.yyyy"/></p>
							<p class="feedLink">
								<g:link url="${feedInstance.link}">${feedInstance.title}</g:link> <br/>
								<g:link controller="feed" action="markRead" params="[id:feedInstance.id]">
									<i class="fa fa-check"></i>
									<g:message code="feed.markRead"/>
								</g:link>
							</p>
						</li>
					</ul>
				</g:each>
			</div>
		</g:else>
	</p>
</div>