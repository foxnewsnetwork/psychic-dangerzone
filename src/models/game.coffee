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