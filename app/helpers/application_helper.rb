module ApplicationHelper

  def selected(localidad)
    if localidad.nil?
      {}
    else
      localidad.provincia_id
    end
  end

  def logo
    image_tag("catalogo_int2015.png", :alt => "INT", :id => 'logo')
  end
end
