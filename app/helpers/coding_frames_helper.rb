module CodingFramesHelper                                  

  def verb_list(verbs, as_links = true)
    mapper = as_links ? ->(x){link_to x, [@language, x]} : ->(x){x}
    raw verbs.order(:verb_form).map(&mapper).join(', ')
  end
  
end
