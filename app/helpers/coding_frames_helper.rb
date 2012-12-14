module CodingFramesHelper                                  

  def verb_list(verbs, as_links = true)
    mapper = as_links ? ->(x){link_to x, [@language, x]} : ->(x){x}
    if verbs.respond_to? :order
      verbs = verbs.order :verb_form
    elsif verbs.is_a? Array
      verbs.sort!{|a, b| a.to_s <=> b.to_s}
    end
    raw verbs.map(&mapper).join(', ')
  end
  
end
