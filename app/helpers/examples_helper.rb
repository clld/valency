module ExamplesHelper

  
  # returns a div of class "gloss-unit" for each gloss to be aligned
  def split_gloss ex
    at_chunks = ex.analyzed_text.split.map! {|str| html_escape(str)}
    gl_chunks = ex.gloss.split.map! do |str|
      html_escape(str).gsub(/(?<![[:alpha:]])([A-Z]+)(?![[:alpha:]])/) { |caps|
        '<span class="sc">' << caps << '</span>'
      }
    end
    gloss_chunks = at_chunks.zip(gl_chunks).map! do |pair|
      pair.join('<br/>').html_safe
    end
    gloss_chunks.map! do |chunk|
      content_tag(:div, chunk, class: "gloss-unit")
    end.join("\n").html_safe
  end
  
end
