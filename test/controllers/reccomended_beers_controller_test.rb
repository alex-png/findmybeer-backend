require 'test_helper'

class ReccomendedBeersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reccomended_beer = reccomended_beers(:one)
  end

  test "should get index" do
    get reccomended_beers_url, as: :json
    assert_response :success
  end

  test "should create reccomended_beer" do
    assert_difference('ReccomendedBeer.count') do
      post reccomended_beers_url, params: { reccomended_beer: { beer_id: @reccomended_beer.beer_id, index: @reccomended_beer.index, integer: @reccomended_beer.integer, user_id: @reccomended_beer.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show reccomended_beer" do
    get reccomended_beer_url(@reccomended_beer), as: :json
    assert_response :success
  end

  test "should update reccomended_beer" do
    patch reccomended_beer_url(@reccomended_beer), params: { reccomended_beer: { beer_id: @reccomended_beer.beer_id, index: @reccomended_beer.index, integer: @reccomended_beer.integer, user_id: @reccomended_beer.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy reccomended_beer" do
    assert_difference('ReccomendedBeer.count', -1) do
      delete reccomended_beer_url(@reccomended_beer), as: :json
    end

    assert_response 204
  end
end
