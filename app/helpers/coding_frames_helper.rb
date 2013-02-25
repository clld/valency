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
  
  # render a coding frame, optionally with a prefixed badge and a hidden arg_count
  # wrap all numbers in <b class="label">, let CSS make the label invisible without class "on"
  # addClass('on') later to dynamically highlight numbers
  # OPTIONS
  #   prefix (boolean, defaults to false): show a 'B'/'D' (basic/derived) prefix
  #   count  (boolean, defaults to dalse): include a hidden span with the argument count
  #     between the prefix and the CF
  #   highlight (array, defaults to []): [2] highlight index no. 2
  #   tooltip   (hash,  defaults to {}): {2 => "covered thing"} adds that tooltip to index no. 2
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
    
    cf_html = ""
    cf_html << "<span class='hidden'>#{cf.arg_count}</span>" if count
    
    cf_html << html_escape(cf.to_s).to_s.gsub(/(.?)(\d+)(.?)/) do
      css_class = "idx-no" # short for: index-number
      n         = $2.to_i
      unless $1.match(/[\[\]]/) # no label for numbers in brackets
        css_class << " label"
        css_class << " off" unless highlight.include? n
      end
      if tooltip[n]
        css_class << " ttip"
        html_attr = "rel='tooltip' title='#{tooltip[n]}'"
      end
      "#{$1}<b class='#{css_class}' #{html_attr}>#{n}</b>#{$3}"
    end
    
    return (prefix ? "#{prefix}<div class='cell'>#{cf_html}</div>" : cf_html).html_safe
    
  end
  
end
