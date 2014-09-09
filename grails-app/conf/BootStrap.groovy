import board.Role
import board.User
import board.UserRole

class BootStrap {

    def init = { servletContext ->
		def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
		def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
	
		def testUser = new User(username: 'testuser', enabled: true, password: 'password')
		testUser.save(flush: true)
		UserRole.create testUser, userRole, true
		
		def testAdmin = new User(username: 'admin', enabled: true, password: 'password')
		testAdmin.save(flush: true)
		
		//admin is both admin role and user role
		//this simplifies controller annotations a bit
		UserRole.create testAdmin, adminRole, true
		UserRole.create testAdmin, userRole, true 
		
		assert User.count() == 2
		assert Role.count() == 2
		assert UserRole.count() == 3
    }
    def destroy = {
    }
}
