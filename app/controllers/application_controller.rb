class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :global_queries
  
  # necessary for languages dropdown,
  # meanings dropdown and more
  def global_queries
    @languages     ||= Language.all
    @meanings_core ||= Meaning.core
  end
  
  

end
