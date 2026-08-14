require 'test_helper'

class CitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city = cities(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get cities_path
    assert_response :success
  end

  test "should get new" do
    get new_city_path
    assert_response :success
  end

  test "should create city" do
    assert_difference('City.count') do
      post cities_path, params: { city: { name: @city.name } }
    end

    assert_redirected_to city_path(City.last)
  end

  test "should show city" do
    get city_path(@city)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_path(@city)
    assert_response :success
  end

  test "should update city" do
    patch city_path(@city), params: { city: { name: @city.name } }
    assert_redirected_to city_path(@city)
  end

  test "should destroy city" do
    assert_difference('City.count', -1) do
      delete city_path(@city)
    end

    assert_redirected_to cities_path
  end
end
