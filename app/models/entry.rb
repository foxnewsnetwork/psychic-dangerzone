class Entry < ActiveRecord::Base
  attr_accessible :header, :hyperlink, :image, :user_id
end
