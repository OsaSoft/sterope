package cz.cvut.fel.hernaosc.via.sterope.feed

import grails.transaction.Transactional

@Transactional
class FeedService {

    def getFeed(user){
		def feed = []
		feed += getRss(user)
		
		return feed
	}
	
	def getRss(user){
		def rss = []
		user.rssFeeds.each{
			//TODO: check for url validity, possibly BEFORE adding the feed
			def feed = new XmlSlurper().parse(it.url)
			def feedItems = feed.item
			def rf = [:]
			rf["title"] = feed.title
			rf["items"] = []
			feedItems.each{
				rf["items"] << it
			}
			
			rss << rf
		}
		
		return rss
	}
}
