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