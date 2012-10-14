class PagesController < ApplicationController
  def home
  end # home

  def edit
  	unless user_signed_in?
  		redirect_to new_user_session_path
  	else
  		@blog = current_user.blogs.new
  		@entry = current_user.entries.new
  	end 
  end # edit

end # PagesController
