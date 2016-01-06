package cz.cvut.fel.hernaosc.via.sterope.feed

import grails.plugin.springsecurity.annotation.Secured

class FeedController {
	def springSecurityService
	def feedService
	
	@Secured(['ROLE_USER'])
	def myFeed(){
		def feed = feedService.getFeed(springSecurityService.currentUser)
		def numNewItems = 0
		feed.each{
			println it.items.size()
			numNewItems += it.items.size()
		}
		
		[feed: feed, numNewItems: numNewItems]
	}
}
