package cz.cvut.fel.hernaosc.via.sterope.feed

import grails.plugin.springsecurity.annotation.Secured

class FeedController {
	def springSecurityService
	def feedService
	
	@Secured(['ROLE_USER'])
	def myFeed(){
		def feedItems = feedService.getFeed(springSecurityService.currentUser) ?: []
		println feedItems
		[feedItems: feedItems]
	}
}
