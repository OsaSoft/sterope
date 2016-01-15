package cz.cvut.fel.hernaosc.via.sterope.feed

import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper

class FeedController {
	def springSecurityService
	def feedService
	
	@Secured(['ROLE_USER'])
	def myFeed(){
		def feed = feedService.getFeed(springSecurityService.currentUser)
		
		[feed: feed, numNewItems: feed.size()]
	}
	
	@Secured(['permitAll'])
	def weather(){
		def url="http://api.openweathermap.org/data/2.5/weather?q=Prague&APPID=132bbdb79f5ce855589ea9cb135b3ee3"
		def d = new JsonSlurper().parseText(url.toURL().text)
		render "${d.weather.description}" - ']' - '['
	}
	
	@Secured(['ROLE_USER'])
	def markRead(Long id){
		def item = FeedItem.findById(id)
		if(!item){
			flash.error = message(code: "default.not.found.message", args: [message(code: 'feed.item.label'),id])
			redirect url: "/"	
		} else if(item.user != springSecurityService.currentUser){
			render view:"/forbidden"
		} else {
			item.done = true
			item.save(flush: true)
			flash.success = message(code: "feed.markRead.success", args: ["$item.feedName - $item.title"])
			redirect url: "/"
		}
	}
	
	@Secured(['ROLE_USER'])
	def markAllRead(){
		FeedItem.findAllByUserAndDone(springSecurityService.currentUser, false).each{
			it.done = true
			it.save(flush: true)
		}
		flash.success = message(code: "feed.markAllRead.success")
		redirect url: "/"
	}
}
