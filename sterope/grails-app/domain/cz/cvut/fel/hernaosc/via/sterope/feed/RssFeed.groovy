package cz.cvut.fel.hernaosc.via.sterope.feed

import cz.cvut.fel.hernaosc.via.sterope.user.User

class RssFeed {
	String name
	String url
	
	static belongsTo = [
		user: User
		]

    static constraints = {
		name nullable: false, blank: false
		url nullable: false, blank: false
    }
	
	def beforeValidate(){
		if(!name){
			name = "RSS"
		}
	}
}
