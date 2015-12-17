import cz.cvut.fel.hernaosc.via.sterope.user.Role
import cz.cvut.fel.hernaosc.via.sterope.user.User
import cz.cvut.fel.hernaosc.via.sterope.user.UserRole

class BootStrap {

	def init = { servletContext ->
		def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true)
		def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true)

		def adminUser = User.findByUsername('admin') ?: new User(
				username: 'admin',
				password: 'admin', //encoded onInsert
				enabled: true,
				firstname: 'Admin',
				lastname: 'Admin',
				email: 'hernaosc@fel.cvut.cz'
				).save(failOnError: true, flush: true)

		if (!adminUser.authorities.contains(userRole)) { UserRole.create adminUser, userRole }
		if (!adminUser.authorities.contains(adminRole)) { UserRole.create adminUser, adminRole }
	}
	def destroy = {
	}
}
