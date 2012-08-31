class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_languages
  
  # necessary for language dropdown as well as others
  def get_languages
    @languages ||= Language.all
  end

end
