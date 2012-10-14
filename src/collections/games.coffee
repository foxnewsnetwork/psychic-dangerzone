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