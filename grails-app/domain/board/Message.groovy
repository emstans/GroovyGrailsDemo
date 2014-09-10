package board
import grails.plugin.springsecurity.SpringSecurityService

class Message {
	
	//User author
	String messageBody
	Date messageDate
	
    static constraints = {
		//author blank: false
		messageBody maxSize:10000, blank: false 
    }
	
	Message(){
		messageDate = new Date()
	}
	
	Message(String messageBody/*, User  user*/){
		messageDate = new Date()
		messageBody = messageBody
		//author = user
	} 
}
