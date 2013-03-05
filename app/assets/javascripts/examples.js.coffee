# JS for Examples
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>tS" # scrolling table
	sScrollY: "600px"
	bPaginate: true
	
	aoColumnDefs: [ # 0: Example (rendered), 1: Verb meaning, 2: Example of...
		{
			aTargets:[0] # Example
			sType: "html"
			asSorting: ['asc','desc']
		}
	]
	aaSorting: [[0,'asc']]
		

@VALENCY.examples =
	init: ->
		
	index: ->
		$dt = $('.dataTable').dataTable $.extend(ns.oDTSettings, oDTSettings_index)
	
	
	show: ->
		@index