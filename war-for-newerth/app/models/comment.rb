# == Schema Information
# Schema version: 20090627162800
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  poster_id  :integer
#  new_id     :integer
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User', :foreign_key => :poster_id
  belongs_to :new
end
