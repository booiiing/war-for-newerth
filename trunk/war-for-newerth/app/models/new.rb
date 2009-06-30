# == Schema Information
# Schema version: 20090630192501
#
# Table name: news
#
#  id         :integer         not null, primary key
#  poster_id  :integer
#  title      :string(255)
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

class New < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User', :foreign_key => :poster_id
  has_many :comments
  
end
