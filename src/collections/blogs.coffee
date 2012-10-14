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