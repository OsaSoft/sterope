package cz.cvut.fel.hernaosc.via.sterope.feed



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RssFeedController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond RssFeed.list(params), model:[rssFeedInstanceCount: RssFeed.count()]
    }

    def show(RssFeed rssFeedInstance) {
        respond rssFeedInstance
    }

    def create() {
        respond new RssFeed(params)
    }

    @Transactional
    def save(RssFeed rssFeedInstance) {
        if (rssFeedInstance == null) {
            notFound()
            return
        }

        if (rssFeedInstance.hasErrors()) {
            respond rssFeedInstance.errors, view:'create'
            return
        }

        rssFeedInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'rssFeed.label', default: 'RssFeed'), rssFeedInstance.id])
                redirect rssFeedInstance
            }
            '*' { respond rssFeedInstance, [status: CREATED] }
        }
    }

    def edit(RssFeed rssFeedInstance) {
        respond rssFeedInstance
    }

    @Transactional
    def update(RssFeed rssFeedInstance) {
        if (rssFeedInstance == null) {
            notFound()
            return
        }

        if (rssFeedInstance.hasErrors()) {
            respond rssFeedInstance.errors, view:'edit'
            return
        }

        rssFeedInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RssFeed.label', default: 'RssFeed'), rssFeedInstance.id])
                redirect rssFeedInstance
            }
            '*'{ respond rssFeedInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(RssFeed rssFeedInstance) {

        if (rssFeedInstance == null) {
            notFound()
            return
        }

        rssFeedInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RssFeed.label', default: 'RssFeed'), rssFeedInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'rssFeed.label', default: 'RssFeed'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
