module VerbsHelper
  
  def meaning_list(verb, as_links = true)
    mapper = as_links ? ->(m){link_to m, m} : ->(m){m}
    raw verb.meanings.map(&mapper).join(', ')
  end

end
