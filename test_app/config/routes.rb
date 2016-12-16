TestApp::Application.routes.draw do
  get "metatags/default"
  get "metatags/options"
  get "metatags/namespaced"
  get "metatags/override_controller"
  get "metatags/override_view"
  get "metatags/arrays"
  get "metatags/page_title"
  get "metatags/site_title"
  get "metatags/full_title"
end
