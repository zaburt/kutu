require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @picture = pictures(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get pictures_path
    assert_response :success
  end

  test "should get new" do
    get new_picture_path
    assert_response :success
  end

  test "should create picture" do
    assert_difference('Picture.count') do
      post pictures_path, params: { picture: { game_id: @picture.game_id, name: @picture.name } }
    end

    assert_redirected_to picture_path(Picture.last)
  end

  test "should show picture" do
    get picture_path(@picture)
    assert_response :success
  end

  test "should get edit" do
    get edit_picture_path(@picture)
    assert_response :success
  end

  test "should update picture" do
    patch picture_path(@picture), params: { picture: { game_id: @picture.game_id, name: @picture.name } }
    assert_redirected_to picture_path(@picture)
  end

  test "should destroy picture" do
    assert_difference('Picture.count', -1) do
      delete picture_path(@picture)
    end

    assert_redirected_to pictures_path
  end
end
