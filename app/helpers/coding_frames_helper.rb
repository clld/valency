module CodingFramesHelper                                  

  EMPTY_HASH = {}
  EMPTY_ARY  = []
  LT, GT, APOSTROPHE = %w(&lt; &gt; &#39;)

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
  def render_cf cf, options = {}
    prefix    = options[:prefix]    || false # prefix a 'B'/'D' label for Basic/Derived?
    highlight = options[:highlight] || EMPTY_ARY  # [2] highlight index no. 2
    tooltip   = options[:tooltip]   || EMPTY_HASH # {2 => "tooltip for 2"}
    if prefix
      prefix = "<div class=\"cell\">"<<
      "<span class=\"label\" title=\"#{cf.derived? ? 'Derived' : 'Basic'} coding frame\">"<<
      "#{cf.derived? ? 'D' : 'B'}</span></div>"
    end
    if !cf.to_s.nil?
      cf_html = cf.to_s.gsub  /</, LT  # replace HTML special symbols
      cf_html.gsub! />/, GT
      cf_html.gsub!(/(V'?)/, '<b>\\1</b>') # make V or V' bold
      cf_html.gsub!(/(\(.+?\)|\[.+?\])/, '<span>\\1</span>') # no linebreak (in brackets)
      cf_html.gsub!(/(\d+)/) do |num|
        n = $1.to_i  # $1 is the number
        css_class = 'idx-no' # for index number
        css_class << ' highlight' if highlight.include?(n)
        if tooltip_text = tooltip[n]
          css_class << ' ttip'
          html_attr = " rel=\"tooltip\" title=\"#{tooltip_text}\""
        end
        "<b class=\"#{css_class}\" data-idx-no=\"#{n}\"#{html_attr}>#{$1}</b>"
      end
      cf_html.gsub!(/'/, APOSTROPHE)
      cf_html = cf_html.html_safe
    
      cf_html = link_to_if(options[:link], cf_html, language_coding_frame_path(cf.language, cf)) do 
        content_tag(:a, cf_html)
      end
      cf_html = "#{prefix}<div class=\"cell\">#{cf_html}</div>" if prefix
      div_for(cf, :'data-arg-count' => cf.arg_count, :class => options[:css_class]) do
        cf_html.html_safe
    end
  end
    
  end
  
end
