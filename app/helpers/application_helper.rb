module ApplicationHelper
  
  def li_wrapped_links_to_same_controller_all_languages
    # If a @language is specified, then this must be
    # the controller of a language-specific resource
    # otherwise, just link to the language
    no_other_controller = @language.nil? || controller_name == 'languages'
    @languages.map do |lang|
      css_class = 'active' if lang == @language
      link_href = no_other_controller ? lang : send('language_' << controller_name + '_path', lang)
      capture do
        content_tag(:li, class: css_class) do
          link_to lang, link_href
        end
      end
    end.join("\n").html_safe
    
  end
  
end

