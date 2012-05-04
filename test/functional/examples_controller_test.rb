require 'test_helper'

class ExamplesControllerTest < ActionController::TestCase
  setup do
    @example = examples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create example" do
    assert_difference('Example.count') do
      post :create, example: { analyzed_text: @example.analyzed_text, comment: @example.comment, gloss: @example.gloss, id: @example.id, media_file_name: @example.media_file_name, media_file_timecode: @example.media_file_timecode, original_orthography: @example.original_orthography, primary_text: @example.primary_text, reference_pages: @example.reference_pages, translation: @example.translation, translation_other: @example.translation_other }
    end

    assert_redirected_to example_path(assigns(:example))
  end

  test "should show example" do
    get :show, id: @example
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @example
    assert_response :success
  end

  test "should update example" do
    put :update, id: @example, example: { analyzed_text: @example.analyzed_text, comment: @example.comment, gloss: @example.gloss, id: @example.id, media_file_name: @example.media_file_name, media_file_timecode: @example.media_file_timecode, original_orthography: @example.original_orthography, primary_text: @example.primary_text, reference_pages: @example.reference_pages, translation: @example.translation, translation_other: @example.translation_other }
    assert_redirected_to example_path(assigns(:example))
  end

  test "should destroy example" do
    assert_difference('Example.count', -1) do
      delete :destroy, id: @example
    end

    assert_redirected_to examples_path
  end
end
