# JS for Examples
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # scrolling table
	bPaginate: false
	
	aoColumnDefs: [ # 0: Example (rendered), 1: Verb meaning, 2: Example of..., 3: Example number
		{
			aTargets:[0] # Example
			sType: "html"
			asSorting: ['asc','desc']
			iDataSort: 3 # Example number (hidden sort column for example)
		}
	]
	aaSorting: [[0,'asc']]
		

@VALENCY.examples =
	init: ->
		
	index: ->
		$dt = $('.dataTable').dataTable $.extend(ns.oDTSettings, oDTSettings_index)
	
	
	show: ->
		@index() # we only use one layout for both index and show actions