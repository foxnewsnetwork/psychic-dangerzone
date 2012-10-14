class BlogsController < ApplicationController
	def create
		Blog.create params[:blog]
		redirect_to "pages/edit"
	end # create

	def index
		@blogs = Blog.order "created_at DESC"
		respond_to do |f|
			f.json { render :json => @blogs }
		end # respond_to
	end # index

	def destroy
		@blog = Blog.find_by_id params[:id]
		@blog.destroy
	end # destroy
end # Blogs
