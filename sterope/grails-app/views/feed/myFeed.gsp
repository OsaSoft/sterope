<div>
	<p>
		<g:if test="${feedItems.isEmpty()}">
			<g:message code="feed.noNew"/>
		</g:if>
		<g:else>
			<g:message code="feed.unread" args="[feedItems.size()]" />
			<div class="feed">
				<ul class="ulFeed">
					<g:each in="${feedItems}" var="feedItem">
						<li>
							${feedItem}
						</li>
					</g:each>
				</ul>
			</div>
		</g:else>
	</p>
</div>