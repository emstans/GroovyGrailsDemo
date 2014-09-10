package board
import org.springframework.security.access.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional


@Transactional(readOnly = true)
class MessageController {
		
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	SpringSecurityService springSecurityService;
	
	//not sure if annotating 'permitAll' is the best practice here
	@Secured(['permitAll']) //anyone can view messages index
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Message.list(params), model:[messageInstanceCount: Message.count()]
    }

	@Secured(['permitAll']) //anyone can view individual messages
    def show(Message messageInstance) {
        respond messageInstance
    }

	@Secured(['ROLE_USER']) //must be logged in to create a new message
    def create() {
		String messageBody;
        respond new Message(messageBody, User.get(springSecurityService.principal.id))
    }

	@Secured(['ROLE_USER'])
    @Transactional
    def save(Message messageInstance) {
        if (messageInstance == null) {
            notFound()
            return
        }

        if (messageInstance.hasErrors()) {
            respond messageInstance.errors, view:'create'
            return
        }

		messageInstance.messageDate = new Date()
		//messageInstance.author = User.get(springSecurityService.principal.id)
		
        messageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'message.label', default: 'Message'), messageInstance.id])
                redirect messageInstance
            }
            '*' { respond messageInstance, [status: CREATED] }
        }
    }

	@Secured(['ROLE_ADMIN']) //only admins can edit messages
    def edit(Message messageInstance) {
        respond messageInstance
    }
	
	@Secured(['ROLE_ADMIN'])
    @Transactional
    def update(Message messageInstance) {
        if (messageInstance == null) {
            notFound()
            return
        }

        if (messageInstance.hasErrors()) {
            respond messageInstance.errors, view:'edit'
            return
        }

        messageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Message.label', default: 'Message'), messageInstance.id])
                redirect messageInstance
            }
            '*'{ respond messageInstance, [status: OK] }
        }
    }
	
	@Secured(['ROLE_ADMIN']) //only admins can delete messages
    @Transactional
    def delete(Message messageInstance) {

        if (messageInstance == null) {
            notFound()
            return
        }

        messageInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Message.label', default: 'Message'), messageInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'message.label', default: 'Message'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
