# JS for Coding frames
@VALENCY or= {}

dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global

# dataTable settings
oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>tS"
	sScrollY: "480px"
	bPaginate: true
	oLanguage:
		sInfoFiltered: " (filtered)"
		sSearch: ""
	# 0: meaning set, 1: role count, 2: meaning no., 3: Meaning, 4: Role frame
	# 5: verb count, 6: microroles
	aoColumnDefs: [
	  {
	    aTargets:[5] # verb count
	    asSorting:['desc','asc']
	  },{
	    aTargets:[6] # microroles
	    asSorting:['asc']
	  },{
	    aTargets:[3, 5] # meaning label and verb count
	    sType:['html']
	  }
	]
	aaSorting: [[2, 'asc']]# sort by meaning number

oDTSettings_show = 
	sDom: "<'row'<'span4'i><'span8'f>>t"
	bPaginate: false
	oLanguage:
		sInfoFiltered: " (filtered)"
		sSearch: ""
  

@VALENCY.meanings =
  init: ->
    
  index: ->
  	$dt = $('#meanings_list').dataTable $.extend ns.oDTSettings, oDTSettings_index
  	$dt.sortEmptyLast('role frame', 'microroles')
    
  show: ->
  	$('#verbs_list').dataTable    $.extend ns.oDTSettings, oDTSettings_show
  
