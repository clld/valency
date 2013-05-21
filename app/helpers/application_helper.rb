module ApplicationHelper
  
  # If a @language is specified then this must be the controller
  # of a language-specific resource. Otherwise, link to language page
  def li_wrapped_links_to_all_languages(link_to_same_controller = false)
    
    keep_controller = link_to_same_controller && @language && 
    controller_name != 'languages'
    @languages.map do |lang|
      css_class = 'active' if lang == @language
      if keep_controller
        target = send('language_' << controller_name + '_path', lang)
        title  = controller_name.humanize + " of " + lang.name
      else
        target = lang
        title  = nil
      end
      capture do
        content_tag(:li, class: css_class) do
          link_to_unless_current lang, target, title: title do
            content_tag(:a, lang, class: 'disabled')
          end
        end
      end
    end.join("\n").html_safe
  end
  
  # generate <li> tags for the submenu (one per controller)
  # used for the controllers of resources nested under a language
  def submenu_items(controller_names, divider=nil)
    if divider then divider = "<li class=\"#{divider}\"></li>" else divider='' end
    
    controller_names.map do |c_name|
      css_class = if @language && c_name == controller_name then 'active' else '' end
      css_class << "#{' ' unless css_class.blank?}disabled" unless @language
      target = send('language_' << c_name << '_path', @language) if @language      
      text  = c_name == 'verbs' ? 'Verb forms' : c_name.humanize
      
      capture do
        content_tag(:li, class: css_class) do
          link_to_unless_current text, target, class: 'cursor-hand' do
            link_to text, '#top'
          end
        end
      end

    end.join("#{divider}\n").html_safe
  end

end

