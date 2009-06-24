module TerritoriesHelper
  
  def set_selected_edit_territory territory
    js = '$$(".active").each(function(e){e.removeClassName("active");});'
    js << "$('select-#{territory.id}').addClassName('active');"
    js << "current_territory=#{territory.id};"
#    js << "dragging = true;"
    js << "if(!territories[current_territory]){territories[current_territory]=new Vertex($('canvas').width / 2,  $('canvas').height / 2) };"
    js << "$('tools-form-container').innerHTML="+render(:partial => 'form', :locals => {:territory => territory})
    js << ";$('territory_position_x').value=territories[current_territory].x;"
    js << "$('territory_position_y').value=territories[current_territory].y;"
    js << "$('territory_shape').value=getVoronoiPath(territories[current_territory], triangle_cache);"
    js << "renderTerritories( $('canvas'), territories );"
    js
  end

  def generate_imagemap_for territories, map_id='map'
    map = "<map name=#{map_id} id=#{map_id}>"
    territories.each do |t|
      map << "<area coords='#{t.shape}' shape='poly' href='#' " +
        "onclick='alert(\"#{t.name}: #{t.clan.name if t.clan}\");return false;' " +
        "onmouseover='console.debug(\"hovering: #{t.name}\")' alt='#{t.name}' />"
    end
    map << "</map>"
  end
end
