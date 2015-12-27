package cz.cvut.fel.hernaosc.via.sterope.ui

class UIController {
	def springSecurityService

    def banner(){
		[user: springSecurityService.currentUser]
	}
}
