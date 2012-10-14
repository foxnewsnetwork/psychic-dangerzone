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