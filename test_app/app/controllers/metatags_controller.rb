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

  def page_title
    meta_page_title "Page Title"
  end

  def site_title
    meta_site_title "Site Title"
  end

  def full_title
    meta_page_title "Page Title"
    meta_site_title "Site Title"
  end

end
