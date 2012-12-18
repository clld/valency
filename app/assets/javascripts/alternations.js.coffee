# JS for Alternations
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global

# sort by alternation name, not by the 'C' or 'U' badge
sort_by_altn_name = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return 'zzz' unless src[iCol]
			console.log($(src[iCol]).find('span:not(.label)').text())
			$(src[iCol]).find(':not(.label)').text?()
		else
			if type is 'set' then src[iCol] = val else src[iCol]


oDTSettings_index = 
  sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
  # sScrollY: "700px"
  bPaginate: false
  oLanguage:
    sInfoFiltered: " (filtered)"
    sSearch: ""
  aoColumnDefs: [ # 0: Altn name, 1: coded? , 2: Description, 3: example, 4: verb count 
    {
      aTargets:[0] # Altn name
      sType: "html"
      sWidth: '20%'
    },{
      aTargets:[2] # Description
      sType: "html"
      sWidth: '30%'
    },{
      aTargets:[3] # Example
      sType: "html"
      sWidth: '45%'
    },{
      aTargets:[4] # verb count
      asSorting: ['desc','asc']
    }
  ]
  aaSorting: [[0,'asc']]

@VALENCY.alternations =
  init: ->
    
  
  index: ->
    $altn_list = $('#altn_list')
    $dt        = $altn_list.dataTable $.extend ns.oDTSettings, oDTSettings_index
    $dt.setCustomSortFunction 'alternation name', sort_by_altn_name
    $dt.sortEmptyLast 'description', 'examples'
    
  
  show: ->
    
  
