# == Schema Information
# Schema version: 20090630192501
#
# Table name: clans
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  color      :string(255)
#  image      :binary
#

class Clan < ActiveRecord::Base
  has_many :users
  has_many :territories
  has_and_belongs_to_many :alliances

  validates_presence_of :name
  validates_presence_of :tag
  validates_presence_of :color
  
  validates_length_of :tag, :within => 2..6

  validates_format_of :color, :with => /^#([A-F]|[a-f]|[0-9]){6}$/,
                      :message => 'Color has to be an hex color in #XXXXXX format'

  def color_rgb
    return [0, 0, 0] unless self.color
    return [self.color[1..2].hex, self.color[3..4].hex, self.color[5..6].hex]
  end

  def get_real_name
    Clan.get_clan_name(official_url) || name
  end

  def fetch_images!
    require 'open-uri'
    off_name = Clan.get_clan_name(official_url)
    dir="#{RAILS_ROOT}/public/images/clans/#{name.underscore.parameterize('_')}"
    FileUtils.mkdir_p dir

    logger.debug "fetching #{"http://www.savage2clans.com/pubsite/clan_img/#{off_name}_128.png"}..."
    img = open("#{dir}/128.png", 'wb')
    img.write open("http://www.savage2clans.com/pubsite/clan_img/#{off_name}_128.png").read
    img.close
    logger.debug "done"

    logger.debug "fetching #{"http://www.savage2clans.com/pubsite/clan_img/#{off_name}_32.png"}..."
    img = open("#{dir}/32.png", 'wb')
    img.write open("http://www.savage2clans.com/pubsite/clan_img/#{off_name}_32.png").read
    img.close
    logger.debug "done"
    
    logger.debug "fetching #{"http://www.savage2clans.com/pubsite/clan_img/#{off_name}_16.png"}..."
    img = open("#{dir}/16.png", 'wb')
    img.write open("http://www.savage2clans.com/pubsite/clan_img/#{off_name}_16.png").read
    img.close
    logger.debug "done"
    
    true
  end

  def image_filename size=32
    file = "clans/#{name.underscore.parameterize('_')}/#{size}.png"
    return false unless [128, 32, 16].include? size and
                          FileTest.exists?("#{RAILS_ROOT}/public/images/#{file}")

    file
  end

  def self.get_clan_name url
    rt = false
    require 'open-uri'
    logger.debug "opening #{url}"
    doc = Nokogiri::HTML((open(url) rescue ''))
    doc.css('div#hello span.titlefont').each do |e|
      rt = e.content.rstrip.gsub("Welcome to the Home of the ", "").gsub(" Clan!", "")
      logger.debug "found! #{rt}"
    end
    rt
  end
end
