struct Celestine::Use < Celestine::Drawable
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  
  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  property target_id : String = ""

  def initialize()
  end

  def initialize(@target_id : Sting)
  end

  def initialize(target : Celestine::Drawable)
    if target.id
      @target_id = target.id.as(String)
    else
      raise "No id on use"
    end
  end
  
  
  def draw(io : IO) : Nil
    io << %Q[<use ]
    class_attribute(io)
    id_attribute(io)
    body_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io)   
    custom_attribute(io)

    io << %Q[href="##{target_id}" ]

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</use>"
    end
  end
end