# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #
  # Draws a border arround the block given. The border is composed of 8 divs,
  # not the most elegant way, but browser-safe.
  # 
  # You'll have to define styles for the border to take effect. Define following
  # css rules, where "classname" should ne changed for whatever identifies your
  # border:
  # .classname, .classname-top, classname-bottom, .classname-left, .classname-right
  # .classname-top-left, .classname-top-right, .classname-bottom-left, .classname-bottom-right
  #
  def border style_name, &proc
    concat("<div class='#{style_name}-top'><div class='#{style_name}-left'>" +
           "<div class='#{style_name}-right'><div class='#{style_name}-bottom'>" +
           "<div class='#{style_name}-top-left'><div class='#{style_name}-top-right'>" +
           "<div class='#{style_name}-bottom-left'><div class='#{style_name}-bottom-right'>" +
           "<div class='#{style_name}'>");
    yield proc;
    concat("</div></div></div></div></div></div></div></div></div>");
  end

  #
  # Creates the links for the crumbs given a dictionary of name => location and
  # an optional separator
  #
  def crumbs locations={}, separator=' / '
    rt = link_to '@ Home', :root
    locations.each_pair do |name, location|
      rt << separator
      rt << link_to(name, location)
    end
    content_for :crumbs do
      rt
    end
  end

end
