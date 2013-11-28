TestApp::Application.routes.draw do
  get "metatags/default"
  get "metatags/options"
  get "metatags/namespaced"
  get "metatags/override_controller"
  get "metatags/override_view"
  get "metatags/arrays"
end
