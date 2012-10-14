# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create :email => "test@test.test", :password => "thisisatestpassword"
user.entries.create :header => "Test Content", :hyperlink => "http://doitfaggot.com", :image => "/faggot.gif"
user.blogs.create :title => "Test entry", :content => "Well, here is some random ass content here"