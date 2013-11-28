# Rails meta tags helpers

## Seo and future-proof meta tags for Rails

The `meta-tags-helpers` gem consists of a set of helpers to setup and render html meta tags in a simple way. It has good customizable defaults that also come with built-in support for open-graph and csrf: all your meta tags in a single call.

Supports both Rails 3 and 4.

### Install

``` rb
gem 'meta-tags-helpers', '~> 0.2.0'
```

### Examples

You could use the default meta tags (see below) inserting the following snippet of `erb` code in your layout. 

``` erb
<%= meta_tags %>
```

if you don't like the defaults you can override them passing other values as a parameter to the `meta_tags` helper.


``` erb
<%= meta_tags(
    :title => "MyBlog - This is a Blog",
    :description => "My blog description & a reserved character that will be escaped",
    :og => {:type => "website"}
    :ns => {
      :my_custom_meta => "a value"
    }
    ) 
%>
```

You can further override these values in your controller, views and partials using the `set_meta` method (see below).

### Generated HTML

The first example above will produce the following html:

``` html
<meta name="charset" content="utf-8" />
<meta name="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width" />
<title>MyBlog - This is a Blog</title>
<meta property="description" content="The blog of mine &amp; a reserved character" />
<meta property="og:url" content="(THE CURRENT REQUESTED URL)" />
<meta property="og:type" content="website" />
<meta property="og:title" content="MyBlog - This is a Blog" />
<meta property="og:description" content="The blog of mine &amp; a reserved character" />
<meta property="ns:my_custom_meta" content="a value" />
<meta name="csrf-param" content="..." />
<meta name="csrf-token" content="..." />

```

### Namespaced Keys

Metas with namespaced keys (eg. `og:title`) are supposed to be RDF properties and so they are rendered using a `property` attribute.

You can equally set namespaced keys through simple key-value pairs (eg. `:"og:type" => "..."`) or with nested hashes (eg. `:og => {:type => "..."}`).

Note that you can also easily render arrays of metas having the same key passing an array as value.

``` rhtml
<%= meta_tags(
    :title => "Escape from New York",
    :description => "Sci-fi film by John Carpenter"
    :og => {
      :type => "video.movie"
    },
    :video => {
      :year => 1981, 
      :actor => ["Kurt Russell", "Lee Van Cleef"]
    }) 
%>
```

### Setting and overriding meta tags from controller/partials/other views

You can set any meta tag from controller, partials or views via the `set_meta` method:

``` rhtml
<!-- application.html.erb: the global settings -->
<%= meta_tags :og => { :type => "website" } %>
```

Override it in a controller:

``` rb
def show
   set_meta "og:type"   => "article"
end
```
In a view:

``` rhtml
  <% set_meta "og:type" => "article" %>
```

**NOTE:** `set_meta(:og => { :type => "article" })` is exactly the same of `set_meta(:"og:type" => "article")` so they will both override the current/default `og:type` meta tag.

You can also customize and read some of defautls (see below) through handy helpers within controllers or views:

``` rb
meta_title(value = nil)
meta_description(value = nil)
meta_image(value = nil)
meta_type(value = nil)

```

### Defaults

This is the default options hash:

``` rb
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

```

**NOTE:** You should supply at least the `title` and the `description`, using `set_meta` or directly as `meta_tags` argument.

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
