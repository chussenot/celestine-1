struct Celestine::Image < Celestine::Drawable
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::Mask

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  property url : String = ""
  
  def draw(io : IO) : Nil
    io << %Q[<image ]
    # Puncuate attributes with a space 
    class_attribute(io)
    id_attribute(io)
    position_attribute(io)
    body_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io) 
    custom_attribute(io)

    io << %Q[href="#{url}" ]

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</image>"
    end
  end
end  