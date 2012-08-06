# meta-tags-helpers

## Rails meta tags helpers

Seo and future-proof meta-tags for Rails, with good customizable defaults that also provide support for open-graph and csrf: all your meta tags in a single call.

### Install

``` rb
gem 'meta-tags-helpers'
```

### Examples

``` erb
<%= meta_tags(
    :title => "MyBlog - This is a Blog",
    :description => "The blog of mine & a reserved character",
    :og => {:type => "website"}
    :ns => {
      :my_custom_meta => "a value"
    }
    ) 
%>
```

or using defaults with setters (see below) just:

``` erb
<%= meta_tags %>
```

### What it generates? 

The first example above will produce the following html:

``` html
<meta name="charset" content="utf-8" />
<meta name="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width" />
<title>MyBlog - This is a Blog</title>
<meta name="description" content="The blog of mine &amp; a reserved character" />
<meta name="og:url" content="(THE CURRENT REQUESTED URL)" />
<meta name="og:type" content="website" />
<meta name="og:title" content="MyBlog - This is a Blog" />
<meta name="og:description" content="The blog of mine &amp; a reserved character" />
<meta name="ns:my_custom_meta" content="a value" />
<meta name="csrf-param" content="..." />
<meta name="csrf-token" content="..." />

```

### Setting meta tags from controller/partials/other views

You can customize some of defautls (see below) through handy helpers within controllers or views:

``` rb
meta_title(value = nil)
meta_description(value = nil)
meta_image(value = nil)
meta_type(value = nil)

```

### Defaults

This is the default options hash:

``` rb
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
  },
  :"csrf-param" => request_forgery_protection_token,
  :"csrf-token" => form_authenticity_token
}
```

---

Copyright (c) 2012 mcasimir

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
