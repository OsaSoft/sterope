package cz.cvut.fel.hernaosc.via.sterope.api

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class ApiController {
	def springSecurityService
	def feedService
	
	@Secured(["ROLE_USER"])
	def feed(){
		def feed = feedService.getFeed(springSecurityService.currentUser)
		render feed as JSON
	}
}
