package cz.cvut.fel.hernaosc.via.sterope.user



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def springSecurityService

	@Secured(['ROLE_ADMIN'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userInstanceCount: User.count()]
    }
	
	@Secured(['ROLE_USER'])
	def show(Long id){
		if(id != springSecurityService.currentUserId && springSecurityService.currentUser.getAuthorities().contains("ROLE_ADMIN")){
			id = springSecurityService.currentUserId
		}
		
		[userInstance: User.get(id)]
	}
	
	@Secured(['ROLE_USER'])
	def profile(){
		respond springSecurityService.currentUser
	}

	@Secured(['ROLE_ADMIN'])
    def create() {
        respond new User(params)
    }
	
	@Secured(['permitAll'])
	def signup(){
		respond new User(params)
	}
	
	@Secured(['permitAll'])
	@Transactional
	def register(User userInstance) {
		if (userInstance == null) {
			notFound()
			return
		}

		if (userInstance.hasErrors()) {
			respond userInstance.errors, view:'signup'
			return
		}

		userInstance.save flush:true
		UserRole.create(userInstance,"ROLE_USER")
		
		flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.firstname + " " + userInstance.lastname])
		redirect controller:"login"
	}
	

	@Secured(['ROLE_ADMIN'])
    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }
	
	@Secured(['ROLE_ADMIN'])
    def edit(User userInstance) {
        respond userInstance
    }

	@Secured(['ROLE_ADMIN'])
    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

	@Secured(['ROLE_ADMIN'])
    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
