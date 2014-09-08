package board

class Message {
	User author
	String messageBody
	Date messageDate = new Date()
	
    static constraints = {
		author blank: false
		messageBody maxSize:10000, blank: false 
    }
}
