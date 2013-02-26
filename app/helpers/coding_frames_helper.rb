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
  # OPTIONS
  #   prefix (boolean, defaults to false): show a 'B'/'D' (basic/derived) prefix
  #   count  (boolean, defaults to dalse): include a hidden span with the argument count
  #     between the prefix and the CF
  #   highlight (array, defaults to []): [2] highlight index no. 2
  #   tooltip   (hash,  defaults to {}): {2 => "broken thing"} adds that tooltip to index no. 2
  def render_cf cf, options = {}
    prefix    = options[:prefix]    || false # prefix a 'B'/'D' label for Basic/Derived?
    count     = options[:count ]    || false # prefix a hidden span with arg_count?
    highlight = options[:highlight] || EMPTY_ARY  # [2] highlight index no. 2
    tooltip   = options[:tooltip]   || EMPTY_HASH # {2 => "tooltip for 2"}
    
    if prefix
      prefix = "<div class='cell'>"<<
      "<span class='label' title='#{cf.derived? ? 'Derived' : 'Basic'} coding frame'>"<<
      "#{cf.derived? ? 'D' : 'B'}</span></div>"
    end
    
    cf_html = count ? "<span class='hidden'>#{cf.arg_count}</span>" : ""
      
    cf_with_markup = html_escape(cf.to_s).to_str
    cf_with_markup.gsub!(/(\[)?(\d+)(\])?/) do |num|
      n         = $2.to_i
      # add class "label", for highlighted numbers, except in brackets
      css_class "label" if highlight.include?(n) && $1 != '['
      if tooltip_text = tooltip[n]
        css_class << " ttip"
        html_attr = " rel='tooltip' title='#{tooltip_text}'"
      end
      "#{$1}<b class='#{css_class}' data-idx-no='#{n}'#{html_attr}>#{n}</b>#{$3}"
    end
    
    cf_html << cf_with_markup
    return (prefix ? "#{prefix}<div class='cell'>#{cf_html}</div>" : cf_html).html_safe
    
  end
  
end
