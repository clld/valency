module CodingFramesHelper                                  

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
  
end
