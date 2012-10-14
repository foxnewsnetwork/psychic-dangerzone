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