# JS for Microroles
@VALENCY or= {}

dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global

# dataTable settings for Microroles index
oDTSettings_index = 
	sDom: "<'row'<'span8'i><'span4'f>>t"
	# TODO inherit oLanguage from global DTSettings, defined in _global.js.coffee

	# 0: meaning label, 1: microrole name, 2: original_or_new,	3: verb count, 4: CF count
	aoColumnDefs: [
	  {
	    aTargets:[3,4] # verb count, coding frame count
	    sType: 'numeric'
	    asSorting:['desc','asc']
	  },{
	    aTargets:[0,1] # meaning label, microrole name
	    sType: 'html'
	  }
	]
	aaSorting: [[0, 'asc']] # sort by meaning number

# dataTable settings for single Microrole
oDTSettings_show = 
	sDom: "<'row'<'span4'i><'span8'f>>t"
  

@VALENCY.microroles =
  init: ->
    
  index: ->
  	$dt = $('#microroles_list').dataTable $.extend true, ns.oDTSettings, oDTSettings_index
    
  show: ->
  	$('#TBA').dataTable    $.extend ns.oDTSettings, oDTSettings_show
  
