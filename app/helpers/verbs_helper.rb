module VerbsHelper
  
  # generate comma-separated list of meanings for a verb
  def meaning_list(verb, as_links = true)
    mapper = as_links ? ->(m){link_to m, m} : ->(m){m}
    raw verb.meanings.map( &mapper ).join(', ')
  end

  # generate comma-separated list of microroles
  # for a coding frame index number (@param cfin)
  def microrole_list(mroles, as_links = true)
    mapper = as_links ? ->(m){link_to m, m} : ->(m){m}
    raw mroles.map( &mapper ).join(', ')
  end
  
  

end
