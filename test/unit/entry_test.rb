# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  header     :string(255)
#  image      :string(255)
#  hyperlink  :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
