class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :global_queries
  
  # necessary for languages dropdown,
  # meanings dropdown and more
  def global_queries
    @languages     ||= Language.all
    @meanings_core ||= Meaning.core
  end
  
  # create action for home page
  def home
    render 'shared/home'
  end

  def about
    if params[:name] != nil then
      render "shared/#{params[:name]}"
    else
      render "shared/project"
    end
  end

end
