# JS for Coding frames
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global
oDTSettings = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
	# sScrollY: "700px"
	bPaginate: false
	oLanguage:
		sInfoFiltered: " (filtered)"
		sSearch: "Filter:"
	aoColumnDefs: [ # 0: Coding frame, 1: derived, 2: arg_count, 3: Meaning labels & Verbs
		{
		  aTargets:[0] # Coding frame
			sType: "html"
			mDataProp: dtapi._sorter_fn_empty_last 0
		},{
		  aTargets:[3] # Meaning labels & Verbs
			sType: "html"
			mDataProp: dtapi._sorter_fn_empty_last 3
		}
	]
    


@VALENCY.coding_frames =
  
  init: ->
    
  index: ->
    $cf_list = $('#coding_frames_list')
    $dt      = $cf_list.dataTable $.extend(ns.oDTSettings, oDTSettings)

    console.log ns.oDTSettings
    
  show: ->
    
