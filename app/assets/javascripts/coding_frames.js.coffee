# JS for Coding frames
@VALENCY or= {}

# dataTable settings
ns = window.VALENCY.global
oDTSettings = 
	'sDom': "<'row'<'span4'i><'span8'f>>tS"
	'sScrollY': "700px"
	'bPaginate': true
	'oLanguage':
		'sInfoFiltered': " (filtered)"
		'sSearch': "Filter:"


@VALENCY.coding_frames =
  
  init: ->
    
  index: ->
    $cf_list   = $('#coding_frames_list')
    
    cf_list_dt = $cf_list.dataTable $.extend(ns.oDTSettings, oDTSettings)
    console.log ns.oDTSettings
    
  show: ->
    
