module CodingFramesHelper                                  

  EMPTY_HASH = {}
  EMPTY_ARY  = []

  # get a comma-separated list of verbs, optionally as links,
  # optionally keeping the meaning parameter
  def verb_list(verbs, as_links = true, meaning = nil)
    if as_links
      if meaning
        mapper = ->(v){
          link_to(v, language_verb_path(@language, v, meaning: meaning.to_param), 
          class: 'object-language')
        }
      else
        mapper = ->(v){ link_to v, [@language, v], class: 'object-language' }
      end
    else
      mapper = ->(x){ content_tag :span, x, class: 'object-language' }
    end
    
    if verbs.respond_to? :order
      verbs = verbs.order :verb_form
    elsif verbs.is_a? Array
      verbs.sort!{|a, b| a.to_s <=> b.to_s}
    end
    
    raw verbs.map(&mapper).join(', ')
  end
  
  # render a coding frame, optionally with a prefixed badge and a hidden <span>arg_count</span>
  # wrap all numbers in <b class="idx-no" data-idx-no="1">
  # addClass("label") dynamically to highlight the labels
  # options can include "link" (boolean), defaults to false
  # option: css_class - class string to be applied to outermost Coding frame div
  # option: language - the language the coding frame belongs to (for the link URL)
  def render_cf cf, options = {}
    prefix    = options[:prefix]    || false # prefix a 'B'/'D' label for Basic/Derived?
    highlight = options[:highlight] || EMPTY_ARY  # [2] highlight index no. 2
    tooltip   = options[:tooltip]   || EMPTY_HASH # {2 => "tooltip for 2"}
    lang      = options[:language]  || @language || nil
    if prefix
      prefix = "<div class='cell'>"<<
      "<span class='label' title='#{cf.derived? ? 'Derived' : 'Basic'} coding frame'>"<<
      "#{cf.derived? ? 'D' : 'B'}</span></div>"
    end
    cf_with_markup = html_escape(cf.to_s).to_str # escape HTML characters < and >
    cf_with_markup.gsub!(/(V'?)/, '<b>\\1</b>')  # make the verb bold
    cf_with_markup.gsub!(/(\[)?(\d+)(\])?/) do |num|
      css_class = "idx-no" # short for index number
      n = $2.to_i
      # add class "label", for highlighted numbers, except in brackets
      unless $1 == '[' || $3 == ']'
        css_class << " free" # for stylesheet and dynamic highlighting
        css_class << " label" if highlight.include?(n)
      end
      if tooltip_text = tooltip[n]
        css_class << " ttip"
        html_attr = " rel='tooltip' title='#{tooltip_text}'"
      end
      "#{$1}<b class='#{css_class}' data-idx-no='#{n}'#{html_attr}>#{n}</b>#{$3}"
    end
    
    cf_html = link_to_if(options[:link] && lang, cf_with_markup.html_safe, [lang, cf])
    cf_html = "#{prefix}<div class='cell'>#{cf_html}</div>" if prefix
    div_for(cf, :'data-arg-count' => cf.arg_count, :class => options[:css_class]) do
      cf_html.html_safe
    end
    
  end
  
end
