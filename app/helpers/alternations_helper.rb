module AlternationsHelper
  CSS_CLASS = {'R'=>'success', 'M'=>'warning', 'N'=>'important'}
  INVERSE = 'inverse'

  def value_label altn_value
    if (value = altn_value.occurs)
      css_class = "label label-#{CSS_CLASS[value[0]] || INVERSE}"
      content_tag(:span, value[0].gsub('-',"\u2013"),
        class: css_class, title: altn_value.title
      ) << content_tag(:span, altn_value.title, :class => "hidden")
    end
  end

end
