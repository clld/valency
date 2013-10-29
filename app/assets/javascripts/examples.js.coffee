# JS for Examples
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # scrolling table
	bPaginate: false
	
	aoColumnDefs: [ # 0: Example (rendered)  1: Comment   2: Verb meaning
	                # 3: Example of...  4: Example number
		{
			aTargets: [0] # Example
			sType: "html"
			asSorting: ['asc','desc']
			iDataSort: 4 # Example number (hidden sort column for example)
		},{ 
			bSortable: false, aTargets: [ 1 ] 
		},{
			aTargets: [4] # sort column for examples
			sType: "numeric" 
		}
	]
	aaSorting: [[0,'asc']]
		

@VALENCY.examples =
	init: ->
		
	index: ->
		$dt = $('.dataTable').dataTable $.extend(ns.oDTSettings, oDTSettings_index)
	
	
	show: ->
		@index() # we only use one layout for both index and show actions