module ApplicationHelper
  
  def link_to_same_controller_with_language(lang)
    ## If a @language is specified, then this must be the controller of a language-specific resource
    ## otherwise, just link to the new language
    ## if this doesn't work, specify language-dependent resources manually like this:
    # @lg_specific_resources ||= %w[verbs coding_frames alternations examples]
    # if @lg_specific_resources.include? controller_name #...
    if  @language.nil? || controller_name == 'languages'
      link_to lang, lang
    else
      link_to lang, send('language_'<<controller_name+'_path', lang)
    end

  end
  
  
  
end

