# coding: utf-8
module ExamplesHelper

  def swap_contibutors_name
    n = Array.new
    @contributors.each do |c|
      a = c.name
      ix = a.rindex(/ +/)
      n.push(a[ix+1..a.length] + ", " + a[0,ix])
    end
    n.join(' & ')
  end

  # returns a div with class "gloss-unit" for each gloss to be aligned
  def format_gloss ex
    return '&nbsp;'.html_safe unless ex.analyzed_text.respond_to? :split
    at_chunks = ex.analyzed_text.split.map! {|str| html_escape(str)}
    unless ex.gloss.respond_to? :split # no gloss to speak of
      gl_chunks = [''] * at_chunks.length
    else # chop up the gloss
      gl_chunks = ex.gloss.split.map! do |str|
        html_escape(str).gsub(/(?<![[:alpha:]&])([A-Za-z]+)(?![[:alpha:];])/) do |abbr|
          html_attrs = if (m = @gloss_abbr[abbr])
            %Q|rel="tooltip" class="sc ttip" title="#{m}"|
          elsif abbr.match /^[A-Z]+$/
            'class="sc"'
          end
            "<span #{html_attrs}>#{abbr}</span>"
        end
      end      
    end # unless
    gloss_chunks = at_chunks.zip(gl_chunks).map! do |word, gloss|
      capture do
        content_tag(:div, word) <<
        content_tag(:div, gloss, {class: "gl"}, false)
      end
    end
    gloss_chunks.map! do |chunk|
      content_tag(:div, chunk, {class: "gloss-unit"})
    end.join("\n").html_safe
  end
  
  # renders a complete example with flexible options:
  # class: the CSS class of the example DIV
  # number_as_link: have the ex. number link to the Example object. Default: false
  # wrap: wrap the entire primary text in an <a> with href to the Example. Default: false
  # gloss: display the gloss. Default: true
  def render_example ex, options = {}
    css_class      = options[:class]          || ''
    wrap           = options[:wrap]           || false
    orig           = options[:orig] && ex.original_orthography || false
    number_as_link = options[:number_as_link] || false
    gloss          = true unless options[:gloss] == false
    if wrap then number_as_link = true unless options[:number_as_link] == false end
    link_title = options[:link_title] || "View details for example #{ex.number}"
    
    link_or_number = "(#{link_to_if(number_as_link, ex.number,
      [@language, ex], title: link_title)})"
    
    first_line = orig && ex.original_orthography || ex.primary_text
    second_line= ex.primary_text if orig
    
    link_or_text = link_to_if(wrap, first_line, [@language, ex], title: link_title)
    transl = "‘#{ex.translation}’" unless ex.translation.blank?
 
    rendered_example = content_tag(:div, link_or_number.html_safe, class: "number")
    unless link_or_text.blank?
      rendered_example << content_tag(:div, class: "body") do
        content_tag(:div, link_or_text.html_safe, class: "object-language") <<
        (orig ? content_tag(:div, second_line.html_safe, class: "object-language"): '') <<
        (gloss ? content_tag(:div, format_gloss(ex), class: "gloss-box"): '') <<
        content_tag(:div, transl, class: "translation")
      end
    end

    # for linked examples show star at the end of the example
    if number_as_link or wrap
      rendered_example << render_comment(ex)
    end
    
    # wrap it in a <div> and serve it
    div_for(ex, class: css_class) { rendered_example }
    
  end

  def render_comment ex
    sym = content_tag(:span, "★", title: "Click here for additional information")
    d = ""
    if ex.translation_other
      d << content_tag(:h3, "Other translation")
      olg = Languageref.find_by_id(ex.language_id_translation_other)
      otrans = ""
      if not olg.nil?
        otrans << content_tag(:i, "#{olg.name}:") << " #{ex.translation_other}"
      else
        otrans << ex.translation_other
      end
      d << content_tag(:p, otrans.html_safe, style: "margin-top:-9px")
    end
    if ex.comment
      c = ex.comment
      d << content_tag(:h3, "Comment")
      d << content_tag(:p, c.html_safe, style: "margin-top:-9px")
    end
    if ex.example_type
      d << content_tag(:h3, "Example type")
      d << content_tag(:p, ex.example_type, style: "margin-top:-9px")
    end
    if ex.reference_id
      d << content_tag(:h3, "Reference")
      @ref = Reference.find_by_id(ex.reference_id)
      if @ref
        r = ""
        if @ref.authors
          a = @ref.authors
          na = ""
          a.split(/ +and +/).each do |fn|
            fn1 = fn.split(/\s*,\s*/)
            na << fn1[0]
          end
          r = "#{na}"
        end
        if @ref.year.to_i == 0
          r << " (#{@ref.article_title})"
        else
          r << " #{@ref.year.to_i}#{@ref.year_disambiguation_letter}"
        end
        if ex.reference_pages
          if ex.reference_pages.match(/^\d+$/)
            r << ", p. #{ex.reference_pages}"
          elsif ex.reference_pages.match(/^\d+[\-\/]\d+$/)
            r << ", pp. #{ex.reference_pages}"
          end
        end
        d << content_tag(:p, "#{r}&nbsp;".html_safe << content_tag(:a, "⇢", href: "/references/#{ex.reference_id}"), style: "margin-top:-9px")
      end
    end
    d << content_tag(:h3, "Example as plain text for copying")
    d << "<pre>"
    if ex.original_orthography
      d << "#{ex.original_orthography}<br />"
    end
    if ex.primary_text
      d << "#{ex.primary_text}<br />"
    end
    
    d << "#{ex.analyzed_text}<br />#{ex.gloss}<br />#{ex.translation}"
    d << "<small><br /><br /><i>Cite:</i><br />"
    d << "#{@language} example No. #{ex.number}<br />In: #{swap_contibutors_name} 2013. #{@language} Valency Patterns.
In: Hartmann, Iren &amp; Haspelmath, Martin &amp; Taylor, Bradley (eds.) 2013.
Valency Patterns Leipzig.
Leipzig: Max Planck Institute for Evolutionary Anthropology.
(Available online at http://valpal.info/languages/#{params[:language_id]}/examples/#{ex.number}, Accessed on #{Time.now.strftime('%Y-%m-%d')})"
    d << "</pre>"
    com = content_tag(:a, sym, rel: "popover", class: "info cursor-hand", title: "#{@language} example No. #{ex.number}", :data => {:content => d})
    com
  end
  
end
