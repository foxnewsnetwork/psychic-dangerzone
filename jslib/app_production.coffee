class AboutView extends Backbone.View
	tagName: "h1" ,
	className: "h1-about" ,
	parent: $("#about") ,
	initialize: (@model) -> ,
	render: ->
		unless @model?
			throw "Calling without a model error About"
		$(@el).appendTo @parent
		@hide()
	, # show
	show: ->
		$(@el).html @model.get("content")
		$(@el).show()
		@parent.show()
	, # show
	hide: ->
		$(@el).hide()
		@parent.hide()
# AboutView

class ContactView extends Backbone.View
	tagName: "dl" ,
	className: "d1-contact" ,
	parent: $("#contact") ,
	container: $("#contact-info") ,
	initialize: (@model) -> ,
	render: ->
		unless @model?
			throw "Calling without a model error contact"
		@container.html $(@el).html(@model.get "content")
		@hide()
	, # show
	show: ->
		$(@parent).show()
		@container.html $(@el).html(@model.get "content")
		$(@el).show()
	, # show
	hide: ->
		$(@parent).hide()
		$(@el).hide()
# AboutView

class BlogView extends Backbone.View
	
# BlogView







class About extends Backbone.Model
	defaults: {
		content: null
	} # defaults
	url: "pages/about" ,
	initialize: ->
		@view = new AboutView(this)
		@fetch()
		@view.render()
	, # initialize
	show: ->
		@view.show()
	, # show
	hide: ->
		@view.hide()
	, # hide
# About

class Game extends Backbone.Model
	defaults:
		title: null ,
		content: null ,
		image: null
	, # defaults
	initialize: (@title) ->
		@url = "games/#{title}"
		@view = new GameView({model: this})
		@fetch()
		@view.render()
	, # initialize
	show: ->
		@view.show()
	, # show
	hide: ->
		@view.hide()
	, # hide

class Blog extends Backbone.Model
	defaults:
		title: null ,
		content: null
	, # defalts
	initialize: (@title) ->
		@url = "blogs/#{title}"
		@view = new BlogView({model: this})
		@fetch()
		@view.render()
	, # initialize
	show: ->
		@view.show()
	, # show
	hide: ->
		@view.hide()
	, # hide
# Blog	

# We try to be referentially pure so we can test easier
# by referentially pure, I mean no side effects
class GameState extends Backbone.Model
	keys: ["about", "contact", "games", "blogs"],
	defaults: {
		about: new About() ,
		contact: new Contact() ,
		games: new Games() ,
		blogs: new Blogs()
	} , # defaults
	goto: (name) ->
		args = Array.prototype.slice.call(arguments)
		switch name
			when "about", "contact", "games", "blogs"
				@show(@hide_all_except(name, args))
			else
				@hide()
		# switch
	, # goto
	show: (options) ->
		name = options["name"]
		params = options["params"]
		switch name
			when "about", "contact", "games", "blogs"
				@get("name").show(params)
			else
				return
	, # show
	# Not pure! The for loop, while bad, may be a necessary evil
	hide_all_except: (name, args) ->
		for key in @keys
			unless key is name
				@get(key).hide()
		return options = {
			"name": name ,
			"params": args
		} # options
	, # hide_all_except
# GameState

class Contact extends Backbone.Model
	defaults: {
		content: null ,
	}
	url: "pages/contact" ,
	initialize: ->
		@view = new ContactView(this)
		@fetch()
		@view.render()
	, # initialize
	show: ->
		@view.show()
	, # show
	hide: ->
		@view.hide()
	# hide
# Contact

class Blogs extends Backbone.Collection
	url: "blogs" ,
	model: Blog ,
	initialize: ->
		@view = new BlogsView({model: this})
		@fetch()
		@view.render()
		@title_hash = {}
	, # initialize
	show: (params) ->
		if params?
			title = params["title"]
			if @has_title(title)
				@get_at(title).show()
			else
				blog = new Blog(title)
				blog.show()
				@push_into(blog)
		else
			@view.show()
	, # show
	hide: ->
		@forEach (blog)->
			blog.hide()
		@view.hide()
	, # hide
	push_into: (blog) ->
		@title_hash[blog.title] = @length
		@push(blog)
	, # push_into
	get_at: (title) ->
		@at @title_hash[title]
	, # get_at
	has_title: (title) ->
		@title_hash[title]?
# Games

class Games extends Backbone.Collection
	url: "games" ,
	model: Game ,
	initialize: ->
		@view = new GamesView({model: this})
		@fetch()
		@view.render()
		@title_hash = {}
	, # initialize
	show: (params) ->
		if params?
			title = params["title"]
			if @has_title(title)
				@get_at(title).show()
			else
				game = new Game(title)
				game.show()
				@push_into(game)
		else
			@view.show()
	, # show
	hide: ->
		@forEach (game)->
			game.hide()
		@view.hide()
	, # hide
	push_into: (game) ->
		@title_hash[game.title] = @length
		@push(game)
	, # push_into
	get_at: (title) ->
		@at @title_hash[title]
	, # get_at
	has_title: (title) ->
		@title_hash[title]?
# Games

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

###########################
# Public Static Void Main #
###########################

PublicStaticVoidMain: ->
	hashname = window.location.hash
	pathname = window.location.pathname
	gamestate = new GameState({hash: hashname, path: pathname})
	app = new App(gamestate)

$ PublicStaticVoidMain()

