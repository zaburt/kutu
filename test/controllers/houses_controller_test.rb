require 'test_helper'

class HousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @house = houses(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get houses_path
    assert_response :success
  end

  test "should get new" do
    get new_house_path
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post houses_path, params: { house: { name: @house.name } }
    end

    assert_redirected_to house_path(House.last)
  end

  test "should show house" do
    get house_path(@house)
    assert_response :success
  end

  test "should get edit" do
    get edit_house_path(@house)
    assert_response :success
  end

  test "should update house" do
    patch house_path(@house), params: { house: { name: @house.name } }
    assert_redirected_to house_path(@house)
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete house_path(@house)
    end

    assert_redirected_to houses_path
  end
end
