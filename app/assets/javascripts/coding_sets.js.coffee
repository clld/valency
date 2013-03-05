# JS for Coding sets
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
	aoColumnDefs: [ # 0: Coding set, 1: Comment,   2: Coding frames,
									# 3: Verbs,	     4: Microroles
		{
			aTargets:[0] # Coding set
			sType: "html"
			asSorting: ['asc','desc']
		},{
			aTargets:[2,3,4] # number columns
			sType: "numeric"
			asSorting: ['desc', 'asc']
		}
	]
	aaSorting: [[4,'desc'], [2,'desc']]
		


@VALENCY.coding_sets =
	init: ->
		
	index: ->
		$dt = $('.dataTable').dataTable $.extend(ns.oDTSettings, oDTSettings_index)
			
	
	show: ->
	  
	