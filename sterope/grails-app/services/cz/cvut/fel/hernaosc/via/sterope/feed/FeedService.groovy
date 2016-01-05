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
		rss += user.rssFeeds
		
		return rss
	}
}
