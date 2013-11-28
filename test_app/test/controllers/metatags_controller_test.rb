require 'test_helper'

class MetatagsControllerTest < ActionController::TestCase
  test "should work with defaults" do

    get :default
    assert_response :success

    assert_select "title"
    assert_select "meta[name='charset']"
    assert_select "meta[name='X-UA-Compatible']"
    assert_select "meta[name='viewport']"
    assert_select "meta[property='og:url']"
    assert_select "meta[property='og:type']"
    assert_select "meta[property='og:title']"
    assert_select "meta[property='og:description']"
    assert_select "meta[property='og:image']"
    assert_select "meta[name='csrf-param']"
    assert_select "meta[name='csrf-token']"

  end

  test "should allow to pass options" do

    get :options
    assert_response :success

    assert_select "title", "My title"
    assert_select "meta[name='description'][content=?]", "My description"
    assert_select "meta[name='charset']"
    assert_select "meta[name='X-UA-Compatible']"
    assert_select "meta[name='viewport']"
    assert_select "meta[property='og:url']"
    assert_select "meta[property='og:type']"
    assert_select "meta[property='og:title'][content=?]", "My title"
    assert_select "meta[property='og:description'][content=?]", "My description"
    assert_select "meta[property='og:image']"
    assert_select "meta[name='csrf-param']"
    assert_select "meta[name='csrf-token']"

  end

  test "should render namespaced as property" do

    get :namespaced
    assert_response :success

    assert_select "title"
    assert_select "meta[name='charset']"
    assert_select "meta[name='X-UA-Compatible']"
    assert_select "meta[name='viewport']"
    assert_select "meta[property='og:url']"
    assert_select "meta[property='og:type']"
    assert_select "meta[property='og:title']"
    assert_select "meta[property='og:description']"
    assert_select "meta[property='og:image']"
    assert_select "meta[name='csrf-param']"
    assert_select "meta[name='csrf-token']"

    assert_select "meta[property='ns:my_custom_meta'][content=?]", "My value"

  end

  test "should get override_controller" do
    get :override_controller
    assert_response :success
    assert_select "title", "Overriden in controller"
  end

  test "should get override_view" do
    get :override_view
    assert_response :success
    assert_select "meta[property='og:type'][content=?]", "video.movie"
  end

  test "should normalize nested" do
    normalized = @controller.send :normalize_meta_hash, {:og => {:video => {:title => "Escape from New York", "actor" => "Kurt Russell"}}}
    assert_equal normalized, {:"og:video:title" => "Escape from New York", :"og:video:actor" => "Kurt Russell"}
  end

  test "should support arrays" do
    get :arrays
    assert_response :success
    assert_select "meta[property='og:video:actor'][content=?]", "Goofy"
    assert_select "meta[property='og:video:actor'][content=?]", "Mikey"
  end


end