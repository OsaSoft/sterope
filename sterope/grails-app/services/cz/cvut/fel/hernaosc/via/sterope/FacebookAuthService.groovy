package cz.cvut.fel.hernaosc.via.sterope

import grails.transaction.Transactional

import org.springframework.social.facebook.api.Facebook
import org.springframework.social.facebook.api.impl.FacebookTemplate

import com.the6hours.grails.springsecurity.facebook.FacebookAuthToken

import cz.cvut.fel.hernaosc.via.sterope.user.FacebookUser
import cz.cvut.fel.hernaosc.via.sterope.user.Role
import cz.cvut.fel.hernaosc.via.sterope.user.User
import cz.cvut.fel.hernaosc.via.sterope.user.UserRole

@Transactional
class FacebookAuthService {

	def springSecurityService
	
	FacebookUser create(FacebookAuthToken token) {
		//println "Create domain for facebook user $token.uid"

		//Use Spring Social Facebook to load details for current user from Facebook API
		Facebook facebook = new FacebookTemplate(token.accessToken.accessToken)
		def fbProfile = facebook.userOperations().userProfile
		String email = fbProfile.email
		String username = "facebook_$fbProfile.id"
		String firstName = fbProfile.firstName
		String lastName = fbProfile.lastName
 
		def person = springSecurityService.currentUser ?: new User(
				username: username,
				password: token.accessToken.accessToken, //not really necessary
				enabled: true,
				accountExpired:  false,
				accountLocked: false,
				passwordExpired: false,

				firstname: firstName,
				lastname: lastName,
				email: email
				).save()
		
		UserRole.create(person, Role.findByAuthority('ROLE_USER'))
		UserRole.create(person, Role.findByAuthority('ROLE_FACEBOOK'))
		FacebookUser fbUser = new FacebookUser(
				uid: token.uid,
				name: fbProfile.getName(),
				accessToken: token.accessToken.accessToken,
				accessTokenExpires: token.accessToken.expireAt,
				user: person
				).save()
				
		person.facebookUser = fbUser
		person.save()
		return fbUser
	}
}
