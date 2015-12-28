package cz.cvut.fel.hernaosc.via.sterope.user

import cz.cvut.fel.hernaosc.via.sterope.user.User

class FacebookUser {

    Long uid
    String accessToken
    Date accessTokenExpires
	String name
	
	static belongsTo = [
		user: User
		]

    static constraints = {
        uid unique: true
    }
}
