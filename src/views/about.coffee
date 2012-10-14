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