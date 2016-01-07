package cz.cvut.fel.hernaosc.via.sterope.feed

import cz.cvut.fel.hernaosc.via.sterope.user.User

class FeedItem {
	String feedName
	String title
	String link
	boolean done = false
	Date date
	
	static belongsTo = [
		user: User
		]

    static constraints = {
		feedName blank: false, nullable: false
		title blank: false, nullable: false
		link blank: false, nullable: false
		date nullable: true
    }
}
