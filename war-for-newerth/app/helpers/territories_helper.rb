module TerritoriesHelper
  
  def set_selected_edit_territory territory
    js = '$$(".active").each(function(e){e.removeClassName("active");});'
    js << "$('select-#{territory.id}').addClassName('active');"
    js << "current_territory=#{territory.id};"
    js << "if(!territories[current_territory]){territories[current_territory]=false };"
    js << "$('tools-form-container').innerHTML="+render(:partial => 'form', :locals => {:territory => territory})
    js
  end
end
