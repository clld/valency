module ApplicationHelper
  
  def li_wrapped_links_to_same_controller_all_languages
    # If a @language is specified, then this must be
    # the controller of a language-specific resource
    # otherwise, just link to the language
    link_to_controller = @language && controller_name == 'languages'
    @languages.map do |lang|
      css_class = 'active' if lang == @language
      link_href = no_other_controller ? lang : send('language_' << controller_name + '_path', lang)
      capture do
        content_tag(:li, class: css_class) do
          link_to lang, link_href, title: controller_name.humanize
        end
      end
    end.join("\n").html_safe
  end
  
  def li_wrapped_nav_links_to_controllers controller_names
    css_class = "disabled" if @language.nil?
    controller_names.map do |c_name|
      link_href = send('language_' << c_name << '_path', @language) if @language
      capture do
        content_tag(:li, :class => css_class, 'data-controller' => c_name) do
          link_to c_name.humanize, link_href
        end
      end
    end.join("\n").html_safe
  end
  
end

