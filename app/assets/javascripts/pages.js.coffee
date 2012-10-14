# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
	class Blog extends Backbone.Model
		defaults:
			header: null ,
			hyperlink: null ,
			image: null ,
			user_id: null
	class Blogs extends Backbone.Collection
		url: "/entries" ,
		model: Blog ,
		retrieve: ->
			@fetch
				url: @url ,
				success: (models, responses) ->
					Backbone.Events.trigger "blogs:retrieved", models
				, # success
				error: (error) ->
					alert error
				# error
			# fetch
		# retrieve

	###########################
	# Dirty Inpure IO-related #
	###########################
	# All dirty inpure slutty functions return nothing and don't change
	# game state, they instead just manage IO
	class GenericView extends Backbone.View
		container: null
		show: ->
			@container.show "effect": "slide"
		hide: ->
			@container.hide "effect": "slide"

	class AboutView extends GenericView
		container: $("#about")
	# AboutView

	class ContactView extends GenericView
		container: $("#contact")
	# ContactView

	class BlogView extends GenericView
		container: $("#blog")
	# BlogView

	class GameView extends GenericView
		container: $("#game")
	# GameView

	class Artist
		@ready: (->
			Backbone.Events.on "blogs:retrieved", (models) ->
				for models in models
					Artist.views["blog"].container.append JSON.stringify(model.toJSON())
				return true
		)() , # ready
		@views:
			"about": new AboutView() ,
			"contact": new ContactView() ,
			"blog": new BlogView() ,
			"game": new GameView()
		, # views
		@show: (name) ->
			for key, view of Artist.views
				if name is key
					view.show()
				else
					view.hide()
		, # show
		@hide: ->
			for key, view of Artist.views
				view.hide()
		# hide
	# Artist

	class Navigation extends Backbone.View
		tagName: "ul",
		className: "ul-header",
		events:
			"click .nav-link-about": "about" ,
			"click .nav-link-contact": "contact" ,
			"click .nav-link-blogs": "blogs" ,
			"click .nav-link-games": "games"
		, # events
		template: _.template("<li class='li-header'><a class='nav-link-<%= target %>' href='#<%= target %>'><%= target %></a></li>") ,
		container: $("#navigation") ,
		render: ->
			@blogs = new Blogs()
			@blogs.retrieve()

			@container.html ""
			for target in ["about","blogs","games","contact"]
				$(@el).append( @template("target": target) )
			$(@el).appendTo(@container)
			$(".load-javascript-faggot").hide()
			Artist.show("blog")
		, # render
		about: ->
			Artist.show("about")
		, # about
		contact: ->
			Artist.show("contact")
		, # contact
		blogs: ->
			Artist.show("blog")
		, # blogs
		games: ->
			Artist.show("game")
		, # games
	# Navigation
	navigation = new Navigation()
	navigation.render()


$.ajaxPrefilter (options, originalOptions, jqXHR) ->
	options.xhrFields = { 	"withCredentials": true }
	jqXHR.setRequestHeader( "X-CSRF-TOKEN", $("meta[name='csrf-token']").attr("content") )
# ajaxPrefilter

methodMap =
	'create': 'POST',
	'update': 'PUT',
	'delete': 'DELETE',
	'read':   'GET'
# methodMap

Backbone.sync = (method, model, options) ->
	type = methodMap[method]
		
	# Default options, unless specified.
	options or (options = {})

	# Default JSON-request options.
	params = {type: type, dataType: 'json'}

	# Ensure that we have a URL.
	if (!options.url)
		params.url = model.url or throw "URL ERROR #{JSON.stringify model}"

	# Ensure that we have the appropriate request data.
	if (!options.data and model and (method is 'create' or method is 'update'))
		params.contentType = 'application/json'
		temp_data = { "authenticity_token" : $("meta[name='csrf-token']").attr "content"	}
		throw "You Must Specifiy a Model Name Error #{JSON.stringify model}" unless model.name?
		temp_data[model.name] = model.serialize() if model.serialize?
		temp_data[model.name] = model.toJSON() unless model.serialize?
		params.data = JSON.stringify( temp_data )
    	
	# For older servers, emulate JSON by encoding the request into an HTML-form.
	if (Backbone.emulateJSON)
		params.contentType = 'application/x-www-form-urlencoded'
		params.data = if params.data then {model: params.data} else {}
	# if

	# For older servers, emulate HTTP by mimicking the HTTP method with `_method`
	# And an `X-HTTP-Method-Override` header.
	if (Backbone.emulateHTTP)
		if (type is 'PUT' or type is 'DELETE')
			if (Backbone.emulateJSON) 
				params.data._method = type
				params.type = 'POST'
				params.beforeSend = (xhr) ->
					xhr.setRequestHeader('X-HTTP-Method-Override', type)
					return
				# params.beforeSend
			# if 
		# if PUT or Delete
	# if HTTP

	# Don't process data on a non-GET request.
	params.processData = false if params.type isnt 'GET' and !Backbone.emulateJSON
		
	# Make the request, allowing the user to override any Ajax options.
	return $.ajax(_.extend(params, options))
# Backbone.sync
