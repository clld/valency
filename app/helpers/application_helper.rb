# encoding: UTF-8
module ApplicationHelper
  NAMES = { # descriptive names for some controllers
    "verbs"    => "Verb forms",
    "meanings" => "Verb meanings",
    "languages"=> "Language contributions"
  }
  LANGUAGE_SPECIFIC = %w(verbs coding_frames coding_sets alternations examples references)
  
  # If a @language is specified then this must be the controller
  # of a language-specific resource. Otherwise, link to language page
  def li_wrapped_links_to_all_languages(link_to_same_controller = false)
    keep_controller = link_to_same_controller && (@language || @current_language) && 
      LANGUAGE_SPECIFIC.include?(controller_name)
    @languages.map do |lang|

      # if lang.name.match(/(English|Ojibwe|Jaminjung|Balinese)/) #HJBB tentative
      if lang.name.match(/(Ojibwe)/) #HJBB tentative
        target = '/languages'
        lang.name = "<i>#{lang.name}</i>".html_safe
        title  = "Coming soon"
      else

        css_class = 'active' if lang == (@language || @current_language)
        if keep_controller
          target = send('language_' << controller_name + '_path', lang)
          title  = controller_name.humanize + " of " + lang.name
        else
          target = lang
          title  = nil
        end

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
    @current_language = @language || @current_language
    
    controller_names.map do |c_name|
      css_class = if @language && c_name == controller_name then 'active' else '' end
      css_class << "#{' ' unless css_class.blank?}disabled" unless @current_language
      target = send('language_' << c_name << '_path', @current_language) if @current_language
      text  = c_name == 'verbs' ? NAMES[c_name] : c_name.humanize
      
      capture do
        content_tag(:li, class: css_class) do
          link_to_unless_current text, target, class: 'cursor-hand' do
            link_to text, '#top'
          end
        end
      end

    end.join("#{divider}\n").html_safe
  end
  
  # generates "pagination" links. Infers the appropriate resource name from `controller_name`.
  # @return [String] HTML links for a resource: previous, list all, next
  # @param  objects [Array] a sorted array of ActiveRecord objects to page through
  # @param  current [Object] the currently displayed object to determine neighbours
  def prev_next_links(objects, current, css_class = "btn btn-mini")
    c_name = controller_name
    pos    = objects.index(current) || 0 # avoid nil index: if not found, assume 0
    pred, succ = objects[pos-1], objects[pos+1] # predecessor, successor (one of these can be nil)
    prefix = 'language_' if @language && c_name == "verbs"
  
    path_one = "#{prefix}#{c_name.singularize}_path".to_sym # e.g. :language_verb_path
    path_all = "#{prefix}#{c_name}_path".to_sym             # e.g. :language_verbs_path

    all_path = prefix ? send(path_all, @language) : send(path_all)

    name_pl  = NAMES[c_name]
    name_sg  = name_pl.singularize
    
    pred_path, succ_path = [pred, succ].map! do |obj| # get paths for objects
      params = {}
      if (obj.is_a? Verb) && (mm = obj.meanings).size > 0
        params[:meaning] = mm.first.to_param
      end
      obj.nil? ? nil : prefix ? send(path_one, @language, obj, params) : send(path_one, obj)
    end
    
    links = ""
    if pred_path
      links << link_to(raw('<i class="icon-chevron-left"></i>'), pred_path,
        class: css_class, title: "Previous #{name_sg}"
      )
    end
    
    links << link_to(raw('<i class="icon-align-justify"></i>'), all_path, class: css_class, title: "Show all #{name_pl}")
    
    if succ_path
      links << link_to(raw('<i class="icon-chevron-right"></i>'), succ_path,
      class: css_class, title: "Next #{name_sg}"
    )
    end
    
    links.html_safe
  end

end

