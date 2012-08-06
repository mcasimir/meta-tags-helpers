# Author::    Maurizio Casimirri (mailto:maurizio.cas@gmail.com)
# Copyright:: Copyright (c) 2012 Maurizio Casimirri
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


module MetaTagsHelpers

  module ActionViewExtension
    
    def meta_tags(*args)
      opts = args.extract_options!
      default = {
        :charset => "utf-8", 
        :"X-UA-Compatible" => "IE=edge,chrome=1", 
        :viewport => "width=device-width",
        :title => meta_title,
        :description => meta_description,
        :og => { 
          :url => "#{request.url}", 
          :type => meta_type || "article",
          :title => opts[:title] || meta_title,
          :description => opts[:description] || meta_description,
          :image => (opts[:og] && opts[:og][:image]) || meta_image
        } 
      }
        
      meta_hash = default.deep_merge(opts)
        
      # separates namespaced keys
      namespaces = meta_hash.select { |k,v| v.is_a?(Hash) }
        
      # delete nil/false/namespaced keys
      meta_hash.delete_if { |k,v| v.blank? || v == false || v.is_a?(Hash)}
        
      namespaces.each { |ns, namespaced|
        namespaced.delete_if { |k,v|
          v.blank? || v == false || v.is_a?(Hash)
        }
        namespaced.each {|k,v|
          meta_hash[:"#{ns}:#{k}"] = v 
        }
      }
        
      html = ""
      html << "<title>#{h(meta_hash.delete(:title)) }</title>\n"
      html << csrf_meta_tags
      meta_hash.each {|k,v|
        html << "<meta name=\"#{h(k)}\" content=\"#{h(v)}\" />\n"  
      }
      html.html_safe
    end
    
  end
  
  module ActionControllerExtension
    extend ActiveSupport::Concern
    included do
      helper_method :meta_title, :meta_description, :meta_image, :meta_type
    end
  
    def meta_title(*args)
      if title = args.first
        @meta_title = title
      else
        @meta_title
      end
    end
      
    def meta_description(*args)
      if desc = args.first
        @meta_description = desc
      else
        @meta_description
      end
    end
      
    def meta_image(*args)
      if img = args.first
        @meta_image = img
      else
        @meta_image
      end
    end

    def meta_type(*args)
      if t = args.first
        @meta_type = t
      else
        @meta_type
      end
    end

end
ActionController::Base.send :include, MetaTagsHelpers::ActionControllerExtension
ActionView::Base.send :include, MetaTagsHelpers::ActionViewExtension