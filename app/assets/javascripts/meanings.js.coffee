# JS for Meanings
@VALENCY or= {}

dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

# dataTable settings
oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t"
	# 0: meaning set, 1: role count, 2: meaning no., 3: Meaning, 4: Role frame
	# 5: verb count, 6: microroles
	aoColumnDefs: [
		{
			aTargets:[5] # verb count
			sType: 'numeric'
			asSorting:['desc','asc']
		},{
			aTargets:[6] # microroles
			asSorting:['asc']
		},{
			aTargets:[3] # meaning label and verb count
			sType: 'html'
		},{
			aTargets:[2] # meaning number
			sType: 'numeric'
		}
	]
	aaSorting: [[2, 'asc']]# sort by meaning number

oDTSettings_show = 
	sDom: "<'row'<'span4'i><'span8'f>>t"
	aoColumnDefs: [
		aTargets:[4] # Coding frame
		sType: "html"
		mDataProp: ns.coding_frame_sorter(4)
	]
	aaSorting: [[4,'asc'],[0,'asc']] # By Coding frame then Language

@VALENCY.meanings =
	init: ->
		
	index: ->
		$dt = $('#meanings_list').dataTable $.extend ns.oDTSettings, oDTSettings_index
		$dt.sortEmptyLast('role frame', 'microroles')
		
	show: ->
		$('#verbs_list').dataTable		$.extend ns.oDTSettings, oDTSettings_show
		$('.ttip').tooltip {placement:'bottom'}
		$('.idx-no').hover -> $(@).toggleClass 'label'
	
