# The only data structure in this whole thing is the gamestate
# it is a model that handles the moving shit around
class App extends Backbone.Routers
	initialize: (@gamestate) -> ,
	routes: {
		"about": "about" ,
		"contact": "contact" ,
		"blog/:title": "blog" ,
		"games/:title": "games" 
	} , # routes
	about: ->
		@gamestate.goto("about")
	, # about
	contact: ->
		@gamestate.goto("contact")
	, # contact
	blog: (title) ->
		@gamestate.goto("blog", title)
	, # blog
	games: (title) ->
		@gamestate.goto("games", title)
	, # games