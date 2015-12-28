package cz.cvut.fel.hernaosc.via.sterope.feed

import grails.transaction.Transactional

@Transactional
class FeedService {

    def getFeed(user){
		def rss = getRss(user)
		
		return rss
	}
	
	def getRss(user){
		def rss = user.rssFeeds
		
		return rss
	}
}
