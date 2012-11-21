module ApplicationHelper
  
  def li_wrapped_links_to_same_controller_all_languages
    # If a @language is specified and the action name is "index"
    # then this must be the controller of a language-specific resource
    # otherwise, link to language page
    same_controller = @language &&
      action_name == 'index' && controller_name != 'languages'
    @languages.map do |lang|
      # css_class = 'active' if lang == @language
      if same_controller
        link_href  = send('language_' << controller_name + '_path', lang)
        link_title = controller_name.humanize + " of " + lang.name
      else
        link_href  = lang
        link_title = nil
      end
      capture do
        content_tag(:li) do #class: css_class
          link_to_unless_current lang, link_href, title: link_title do
            content_tag(:a, lang, class: 'disabled')
          end
        end
      end
    end.join("\n").html_safe
  end
  
  def li_wrapped_nav_links_to_controllers controller_names
    css_class = "disabled" if @language.nil?
    controller_names.map do |c_name|
      link_href = send('language_' << c_name << '_path', @language) if @language
      capture do
        displayed_name = c_name == 'verbs' ? 'Verb forms' : c_name.humanize
        content_tag(:li, :class => css_class, 'data-controller' => c_name) do
          link_to_unless_current displayed_name, link_href do
            content_tag(:a, displayed_name)
          end
        end
      end
    end.join("\n").html_safe
  end
  
end

