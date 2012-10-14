class EntriesController < ApplicationController
	def index
		@entries = Entry.all
		respond_to do |f|
			f.json { render :json => @entries }
		end # respond_to
	end # index
	
	def create
		@entry = Entry.create params[:entry]
		redirect_to "pages/edit"
	end # create

	def destroy
		@entry = Entry.find_by_id( params[:id] )
		@entry.destroy
	end # destroy
end # Entries
