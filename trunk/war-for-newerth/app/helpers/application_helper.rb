# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def border style_name='border3', &proc
    concat("<div class='#{style_name}-top'>");
    concat("<div class='#{style_name}-left'>");
    concat("<div class='#{style_name}-right'>");
    concat("<div class='#{style_name}-bottom'>");
    concat("<div class='#{style_name}-top-left'>");
    concat("<div class='#{style_name}-top-right'>");
    concat("<div class='#{style_name}-bottom-left'>");
    concat("<div class='#{style_name}-bottom-right'>");
    concat("<div class='#{style_name}'>");
    yield proc;
    concat("</div>");
    concat("</div>");
    concat("</div>");
    concat("</div>");
    concat("</div>");
    concat("</div>");
    concat("</div>");
    concat("</div>");
    concat("</div>");
  end
end
