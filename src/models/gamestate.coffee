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