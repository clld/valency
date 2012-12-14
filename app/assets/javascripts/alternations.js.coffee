# JS for Alternations
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global

oDTSettings_index = 
  sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
  # sScrollY: "700px"
  bPaginate: false
  oLanguage:
    sInfoFiltered: " (filtered)"
    sSearch: ""
  aoColumnDefs: [ # 0: Altn name, 1: description
    {
      aTargets:[0] # Altn name
      sType: "html"
      sWidth: '25%'
    }
  ]

@VALENCY.alternations =
  init: ->
    
  
  index: ->
    $altn_list = $('#altn_list')
    $dt        = $altn_list.dataTable $.extend(ns.oDTSettings, oDTSettings_index)
    
  
  show: ->
    
  
