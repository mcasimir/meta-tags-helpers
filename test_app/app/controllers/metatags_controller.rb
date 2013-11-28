class MetatagsController < ApplicationController
  def default
  end

  def options
    @options = { 
      title: "My title", 
      description: "My description" 
    }
  end

  def namespaced
    @options = {
      ns: { 
        my_custom_meta: "My value"
      }
    }
  end

  def override_controller
    set_meta( { title: "Overriden in controller" })
  end

  def override_view
  end

  def override_controller_and_view
  end

  def arrays
    @options = {:og => {:video => { :actor => ["Mikey", "Goofy"] }}}
  end
end
