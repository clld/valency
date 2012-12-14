module ApplicationHelper
  
  # If a @language is specified and the action name is "index"
  # then this must be the controller of a language-specific resource
  # otherwise, link to language page
  def li_wrapped_links_to_same_controller_all_languages
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
  
  # generate <li> tags for the submenu (one per controller)
  # used for the controllers of resources nested under a language
  def submenu_tabs(controller_names)
    controller_names.map do |c_name|
      
      # 
      # if c_name == 'languages'
      #   link_href = if @language then language_path(@language) else languages_path end
      # else
      #   link_href = send('language_' << c_name << '_path', @language) if @language
      # end
      # 
      # displayed_name = if c_name == 'verbs' then 'Verb forms'
      #   elsif c_name == 'languages' && action_name == '' then 'Overview'
      #   else  c_name.humanize end
      css_class = if c_name == controller_name then 'active' else '' end
      css_class << ' disabled' unless @language
      link_href = send('language_' << c_name << '_path', @language) if @language      

      capture do
        content_tag(:li, class: css_class) do
          link_to_unless_current c_name.humanize, link_href, class: 'cursor-hand' do
            content_tag(:a, c_name.humanize)
          end
        end
      end

    end.join("\n").html_safe
  end

end

