module AlternationsHelper
  CSS_CLASS = {'R'=>'success', 'M'=>'warning', 'N'=>'important'}
  SORT_ORDER = Hash.new 'Z'
  SORT_ORDER.update('R'=>'A','M'=>'B','N'=>'C')
  INVERSE = 'inverse'

  def value_label altn_value
    if (value = altn_value.occurs)
      css_class = "label label-#{CSS_CLASS[value[0]] || INVERSE}"
      content_tag(:span, value[0].gsub('-',"\u2013"),
        class: css_class, title: altn_value.title, :'data-sort' => SORT_ORDER[value[0]]
      ) << content_tag(:span, altn_value.title, :class => "hidden")
    end
  end

end
