# coding: utf-8
module ExamplesHelper
  
  # returns a div with class "gloss-unit" for each gloss to be aligned
  def format_gloss ex
    at_chunks = ex.analyzed_text.split.map! {|str| html_escape(str)}
    gl_chunks = ex.gloss.split.map! do |str|
      html_escape(str).gsub(/(?<![[:alpha:]])([A-Z]+)(?![[:alpha:]])/) { |caps|
        '<span class="sc">' << caps << '</span>'
      }
    end
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
    number_as_link = options[:number_as_link] || false
    gloss          = true unless options[:gloss] == false
    if wrap then number_as_link = true unless options[:number_as_link] == false end
    link_title = options[:link_title] || "View details for example #{ex.number}"
    
    link_or_number = '(' << link_to_if(number_as_link, ex.number.to_s,
      [@language, ex], title: link_title) << ')'
    
    link_or_text = link_to_if(wrap, ex.primary_text, [@language, ex], title: link_title)
    
    rendered_example =
      content_tag(:div, link_or_number.html_safe, class: "number") <<
      content_tag(:div, class: "body") do
        content_tag(:div, link_or_text.html_safe, class: "object-language") <<
        (gloss ? content_tag(:div, format_gloss(ex), class: "gloss-container") : '') <<
        content_tag(:div, "‘#{ex.translation}’", class: "translation")
      end
    
    # wrap it in a <div> and serve it
    div_for(ex, class: css_class) { rendered_example }
    
  end
  
end
