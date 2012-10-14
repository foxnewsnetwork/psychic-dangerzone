# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Blog < ActiveRecord::Base
  attr_accessible :content, :title

  belongs_to :user
  
  before_save do |blog|
  	blog.slug = blog.title.downcase.gsub(" ", "-")
  end # before each
end
