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
    
    def meta_tags(opts = {})
 
      opts = normalize_meta_hash(opts)

      default   = {
        :charset           => "utf-8", 
        :"X-UA-Compatible" => "IE=edge,chrome=1", 
        :viewport          => "width=device-width",
        :"og:url"          => "#{request.url}", 
        :"og:type"         => "article",
        :"og:title"        => opts[:title],
        :"og:description"  => opts[:description],
        :"og:image"        => opts[:"og:image"],
        :"csrf-param"      => request_forgery_protection_token,
        :"csrf-token"      => form_authenticity_token
      }

      override_hash = controller.instance_variable_get("@_meta_tags_hash") || {}      
      meta_hash = default.deep_merge(opts).deep_merge(override_hash)
        
      html = ""
      html << "<title>#{h(meta_hash.delete(:title)) }</title>\n"
      meta_hash.each {|k,value_or_array|
        values = value_or_array.is_a?(Array) ? value_or_array : [value_or_array]
        values.each { |v|
          if k.to_s =~ /[a-zA-Z_][-a-zA-Z0-9_.]\:/
            html << "<meta property=\"#{h(k)}\" content=\"#{h(v)}\" />\n"  
          else
            html << "<meta name=\"#{h(k)}\" content=\"#{h(v)}\" />\n"  
          end
        }
      }
      html.html_safe
    end
    
  end #~ ActionViewExtension
  
  module ActionControllerExtension
    extend ::ActiveSupport::Concern
    included do
      helper_method :set_meta, :meta_title, :meta_description, :meta_image, :meta_type, :normalize_meta_hash
    end
    
    def _meta_tags_hash
      @_meta_tags_hash ||= {}
    end
  
    def set_meta(options)
      _meta_tags_hash.deep_merge!(normalize_meta_hash(options))
    end
  
    def meta_title(val = nil)
      if val
        @_meta_title = val
        set_meta(:title => val)
      end
      
      @_meta_title
    end
      
    def meta_description(val = nil)
      if val
        @_meta_description = val
        set_meta(:description => val)
      end
      @_meta_description
    end
      
    def meta_image(val = nil)
      if val
        @_meta_image = val
        set_meta(:og => { :image => val })
      end
      @_meta_image
    end

    def meta_type(val = nil)
      if val
        @_meta_type = val
        set_meta(:og => { :type  => val })
      end
      @_meta_type
    end
    
    protected
    
    def normalize_meta_hash(hash)
      normalized = {}
      normalize_meta_hash_walker(hash, normalized)
      normalized
    end

    private
    
    def normalize_meta_hash_walker(hash, normalized, current = nil)
      hash.each do |k, v|
        thisPath = current ? current.dup : []
        thisPath << k.to_s

        if v.is_a?(Hash)
          normalize_meta_hash_walker(v, normalized, thisPath) 
        elsif v
          key = thisPath.join ":"
          normalized[:"#{key}"] = v
        end
      end
    end

  end
end
ActionController::Base.send :include, MetaTagsHelpers::ActionControllerExtension
ActionView::Base.send :include, MetaTagsHelpers::ActionViewExtension
