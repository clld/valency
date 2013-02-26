module CodingFramesHelper                                  

  EMPTY_HASH = {}
  EMPTY_ARY  = []
  # get a comma-separated list of verbs 
  def verb_list(verbs, as_links = true)
    if as_links
      mapper = ->(x){ link_to x, [@language, x], class: 'object-language' }
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
  def render_cf cf, options = {}
    link      = options[:link]      || true  # link to the Coding frame
    prefix    = options[:prefix]    || false # prefix a 'B'/'D' label for Basic/Derived?
    highlight = options[:highlight] || EMPTY_ARY  # [2] highlight index no. 2
    tooltip   = options[:tooltip]   || EMPTY_HASH # {2 => "tooltip for 2"}
    
    if prefix
      prefix = "<div class='cell'>"<<
      "<span class='label' title='#{cf.derived? ? 'Derived' : 'Basic'} coding frame'>"<<
      "#{cf.derived? ? 'D' : 'B'}</span></div>"
    end
    cf_with_markup = html_escape(cf.to_s).to_str # escape HTML characters < and >
    cf_with_markup.gsub!(/(V'?)/, '<b>\\1</b>')  # make the verb bold
    cf_with_markup.gsub!(/(\[)?(\d+)(\])?/) do |num|
      css_class = "idx-no" # short for index number
      css_class << " free" # free means not in brackets. Required for stylesheet and dynamic highlighting
      n = $2.to_i
      # add class "label", for highlighted numbers, except in brackets
      css_class << " label" if highlight.include?(n) && $1 != '['
      if tooltip_text = tooltip[n]
        css_class << " ttip"
        html_attr = " rel='tooltip' title='#{tooltip_text}'"
      end
      "#{$1}<b class='#{css_class}' data-idx-no='#{n}'#{html_attr}>#{n}</b>#{$3}"
    end
    
    cf_html = link_to_if(link && @language, cf_with_markup.html_safe, [@language, cf])
    cf_html = "#{prefix}<div class='cell'>#{cf_html}</div>" if prefix
    div_for(cf, :'data-arg-count' => cf.arg_count) {cf_html.html_safe}
    
  end
  
end
