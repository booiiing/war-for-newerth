# == Schema Information
# Schema version: 20090604162055
#
# Table name: matches
#
#  id          :integer         not null, primary key
#  schedule    :datetime
#  attacker_id :integer
#  defender_id :integer
#  winner_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Match < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :winner, :class_name => 'Clan', :foreign_key => :winner_id
  belongs_to :attacker, :class_name => 'Clan', :foreign_key => :attacker_id
  belongs_to :defender, :class_name => 'Clan', :foreign_key => :defender_id
  
end
