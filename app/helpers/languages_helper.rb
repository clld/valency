module LanguagesHelper

  def contributors_as_links lang, with_link = true
    lang.get_contributors.map do |contr|
      content_tag( :span, class: 'person') do
        link_to_if( with_link, contr.to_s, contr) 
      end
    end.to_sentence.html_safe
  end
  
  def region_id region
    "region-#{region.match(/\w+/).to_s.downcase}"
  end

end
