import grails.rest.render.json.JsonRenderer
import cz.cvut.fel.hernaosc.via.sterope.feed.FeedItem

// Place your Spring DSL code here
beans = {
	feedItemJSONRenderer(JsonRenderer, FeedItem) {
		excludes = ['class','id','done','user']
	}
}
