class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
		"/profile"(controller: "user", action: "profile")

        "/"(view:"/index")
        "500"(view:'/error')
	}
}
