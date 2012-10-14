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