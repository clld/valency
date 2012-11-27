module LanguagesHelper

  def contributors_as_links lang, with_link = true
    lang.get_contributors.map do |contr|
      content_tag( :span, class: 'person') do
        link_to_if( with_link, contr.to_s, contr) 
      end
    end.to_sentence.html_safe
  end
  
  # load JS libraries required for displaying Google maps
  def enable_gmaps
    content_for :scripts do
      javascript_include_tag("gmaps4rails/gmaps4rails.base") <<
      javascript_include_tag("gmaps4rails/gmaps4rails.googlemaps")
    end
  end


end
