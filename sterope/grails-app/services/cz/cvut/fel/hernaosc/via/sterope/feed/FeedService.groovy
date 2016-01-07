package cz.cvut.fel.hernaosc.via.sterope.feed

import grails.transaction.Transactional

import com.joestelmach.natty.Parser

@Transactional
class FeedService {

	def getFeed(user){
		updateRss(user)

		return FeedItem.findAll("FROM FeedItem as f WHERE f.user=:u AND f.done=false ORDER BY f.date DESC", [u: user])
	}

	def updateRss(user){
		def rss = []
		user.rssFeeds.each{
			//TODO: check for url validity, possibly BEFORE adding the feed
			def feed = new XmlSlurper().parse(it.url)
			def feedItems = feed.depthFirst().findAll{it.name() == "item"}

			feedItems.each{
				if(!FeedItem.findWhere(feedName: feed.channel.title.toString(), title: it.title.toString(), link: it.link.toString(), user: user)){
					def d = it.date?.toString() ?: it.pubDate?.toString()
					/*def dateFormat = determineDateFormat(date)
					 date = dateFormat*/
					def date
					if(d){
						def p = new Parser().parse(d).dates
						date = p.size() > 0 ? p.get(0) : null
					}
					date = date ?: new Date()

					def fi = new FeedItem(
							feedName: feed.channel.title.toString(), user: user, title: it.title.toString(),
							link: it.link.toString(), date: date
							)
					fi.save()
					if(fi.hasErrors()){
						println fi.errors
					}
				}
			}
		}
	}

	/*private def DATE_FORMAT_REGEXPS = [
	 '^\\d{8}$': 'yyyyMMdd',
	 '^\\d{1,2}-\\d{1,2}-\\d{4}$': 'dd-MM-yyyy',
	 '^\\d{4}-\\d{1,2}-\\d{1,2}$': 'yyyy-MM-dd',
	 '^\\d{1,2}/\\d{1,2}/\\d{4}$': 'MM/dd/yyyy',
	 '^\\d{4}/\\d{1,2}/\\d{1,2}$': 'yyyy/MM/dd',
	 '^\\d{1,2}\\s[a-z]{3}\\s\\d{4}$': 'dd MMM yyyy',
	 '^\\d{1,2}\\s[a-z]{4,}\\s\\d{4}$': 'dd MMMM yyyy',
	 '^\\d{12}$': 'yyyyMMddHHmm',
	 '^\\d{8}\\s\\d{4}$': 'yyyyMMdd HHmm',
	 '^\\d{1,2}-\\d{1,2}-\\d{4}\\s\\d{1,2}:\\d{2}$': 'dd-MM-yyyy HH:mm',
	 '^\\d{4}-\\d{1,2}-\\d{1,2}\\s\\d{1,2}:\\d{2}$': 'yyyy-MM-dd HH:mm',
	 '^\\d{1,2}/\\d{1,2}/\\d{4}\\s\\d{1,2}:\\d{2}$': 'MM/dd/yyyy HH:mm',
	 '^\\d{4}/\\d{1,2}/\\d{1,2}\\s\\d{1,2}:\\d{2}$': 'yyyy/MM/dd HH:mm',
	 '^\\d{1,2}\\s[a-z]{3}\\s\\d{4}\\s\\d{1,2}:\\d{2}$': 'dd MMM yyyy HH:mm',
	 '^\\d{1,2}\\s[a-z]{4,}\\s\\d{4}\\s\\d{1,2}:\\d{2}$': 'dd MMMM yyyy HH:mm',
	 '^\\d{14}$': 'yyyyMMddHHmmss',
	 '^\\d{8}\\s\\d{6}$': 'yyyyMMdd HHmmss',
	 '^\\d{1,2}-\\d{1,2}-\\d{4}\\s\\d{1,2}:\\d{2}:\\d{2}$': 'dd-MM-yyyy HH:mm:ss',
	 '^\\d{4}-\\d{1,2}-\\d{1,2}\\s\\d{1,2}:\\d{2}:\\d{2}$': 'yyyy-MM-dd HH:mm:ss',
	 '^\\d{1,2}/\\d{1,2}/\\d{4}\\s\\d{1,2}:\\d{2}:\\d{2}$': 'MM/dd/yyyy HH:mm:ss',
	 '^\\d{4}/\\d{1,2}/\\d{1,2}\\s\\d{1,2}:\\d{2}:\\d{2}$': 'yyyy/MM/dd HH:mm:ss',
	 '^\\d{1,2}\\s[a-z]{3}\\s\\d{4}\\s\\d{1,2}:\\d{2}:\\d{2}$': 'dd MMM yyyy HH:mm:ss',
	 '^\\d{1,2}\\s[a-z]{4,}\\s\\d{4}\\s\\d{1,2}:\\d{2}:\\d{2}$': 'dd MMMM yyyy HH:mm:ss',
	 ]
	 private String determineDateFormat(String dateString) {
	 if(!dateString) return null
	 for (String regexp : DATE_FORMAT_REGEXPS.keySet()) {
	 if (dateString.toLowerCase().matches(regexp)) {
	 return DATE_FORMAT_REGEXPS.get(regexp)
	 }
	 }
	 return null
	 }*/
}
