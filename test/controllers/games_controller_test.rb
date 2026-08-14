require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get games_path
    assert_response :success
  end

  test "should get new" do
    get new_game_path
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post games_path, params: { game: { address: @game.address, city_id: @game.city_id, email: @game.email, facebook: @game.facebook, game_category_id: @game.game_category_id, game_times: @game.game_times, house_id: @game.house_id, instagram: @game.instagram, lat: @game.lat, lng: @game.lng, name: @game.name, phone: @game.phone, story: @game.story, twitter: @game.twitter, website: @game.website } }
    end

    assert_redirected_to game_path(Game.last)
  end

  test "should show game" do
    get game_path(@game)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_path(@game)
    assert_response :success
  end

  test "should update game" do
    patch game_path(@game), params: { game: { address: @game.address, city_id: @game.city_id, email: @game.email, facebook: @game.facebook, game_category_id: @game.game_category_id, game_times: @game.game_times, house_id: @game.house_id, instagram: @game.instagram, lat: @game.lat, lng: @game.lng, name: @game.name, phone: @game.phone, story: @game.story, twitter: @game.twitter, website: @game.website } }
    assert_redirected_to game_path(@game.reload)
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete game_path(@game)
    end

    assert_redirected_to games_path
  end
end
