require 'test_helper'

class ReferencesControllerTest < ActionController::TestCase
  setup do
    @reference = references(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:references)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reference" do
    assert_difference('Reference.count') do
      post :create, reference: { additional_information: @reference.additional_information, article_title: @reference.article_title, authors: @reference.authors, bibtex_type: @reference.bibtex_type, book_title: @reference.book_title, city: @reference.city, editors: @reference.editors, full_reference: @reference.full_reference, id: @reference.id, issue: @reference.issue, journal: @reference.journal, latex_cite_key: @reference.latex_cite_key, pages: @reference.pages, publisher: @reference.publisher, series_title: @reference.series_title, url: @reference.url, volume: @reference.volume, year: @reference.year, year_disambiguation_letter: @reference.year_disambiguation_letter }
    end

    assert_redirected_to reference_path(assigns(:reference))
  end

  test "should show reference" do
    get :show, id: @reference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reference
    assert_response :success
  end

  test "should update reference" do
    put :update, id: @reference, reference: { additional_information: @reference.additional_information, article_title: @reference.article_title, authors: @reference.authors, bibtex_type: @reference.bibtex_type, book_title: @reference.book_title, city: @reference.city, editors: @reference.editors, full_reference: @reference.full_reference, id: @reference.id, issue: @reference.issue, journal: @reference.journal, latex_cite_key: @reference.latex_cite_key, pages: @reference.pages, publisher: @reference.publisher, series_title: @reference.series_title, url: @reference.url, volume: @reference.volume, year: @reference.year, year_disambiguation_letter: @reference.year_disambiguation_letter }
    assert_redirected_to reference_path(assigns(:reference))
  end

  test "should destroy reference" do
    assert_difference('Reference.count', -1) do
      delete :destroy, id: @reference
    end

    assert_redirected_to references_path
  end
end
