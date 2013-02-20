module CodingFramesHelper                                  

  EMPTY_HASH = {}

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
  #   highlight (hash, defaults to {}): {2 => "blah"} will highlight 2 and show tooltip "blah"
  
  def render_cf cf, options = {}
    prefix = options[:prefix] || false # prefix a 'B'/'D' label for Basic/Derived?
    count  = options[:count ] || false # prefix a hidden span with arg_count?
    highlight = options[:highlight] || EMPTY_HASH
    
    if prefix
      prefix = "<div class='cell'>"<<
      "<span class='label' title='#{cf.derived? ? 'Derived' : 'Basic'} coding frame'>"<<
      "#{cf.derived? ? 'D' : 'B'}</span></div>"
    end
    
    
  end
  
  # highlight index numbers in a Coding Frame string
  # '1' as label, '[1]' no label, but both with optional tooltip 
  
end
