# JS for Verbs
@VALENCY or= {}

@altn_occurs_sort_order =
	"Regularly" :"A"
	"Marginally":"B"
	"Never"     :"C"

@VALENCY.verbs =
	init: ->
		@altn_occurs_sort_order =
			"Regularly" :"A"
			"Marginally":"B"
			"Never"     :"C"
		
		# $(document).on 'finalized', ->
			# do this last
	
	index: ->
		
	
	show: ->
		
	

setup_reveal_below = ->
	$('div.reveal-me').hide()
	$('a.reveal-below').click ->
		$concealed = $(this).parent().next('.reveal-me')
		$(this).slideUp 30, ->
			$concealed.slideToggle()
	
# hides dataTables column by index
hideColumn = (datatable, index) ->
	datatable.fnSetColumnVis?(index, false)
	
# hide all columns with class "empty"
hideEmptyColumns = (datatable) ->
	datatable.find?('thead th').each (index, el) ->
		hideColumn(datatable, index) if $(el).hasClass('empty')

# toggles visibility of a dataTable column by index
toggleColumn = (datatable, index) ->
	visible = datatable.fnSettings?().aoColumns[index]?.bVisible		
	datatable.fnSetColumnVis?(index, if visible then false else true)
	not visible

$(document).ready ->
	setup_reveal_below()
	
	$('#verbs_list').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>tS"
		"sScrollY": "700px"
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"
			
	window.altn_values_dt = $('#alternation_values_list').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>t" # removed info display
		"bPaginate": false
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"
		"aaSorting": [[1,'asc'], [0,'asc']]
		# custom column settings
		# colums are: 0:altn_name, 1:occurs, 2:comment, 3:coded, 4:derived_cf, 5:example
		"aoColumnDefs": [
			{
				"aTargets":[0,2,4,5]
				"sType": "html"
			},
			{
				"aTargets": [1] # column 1: Occurs
				"mDataProp": ( src, type, val ) ->
					if type == 'set'
						src[1] = val
					else if type == 'sort'
						@altn_occurs_sort_order[src[1]] || "Z"
					else
						src[1]
			},
			{
				"aTargets": [2] # comment (if any)
				"sWidth"  : "15%"
			},
			{
				"aTargets": [5] # comment (if any)
				"sWidth"  : "40%"
			},
			{
				"aTargets" :[3,4,5]
				"asSorting":['desc', 'asc']
			}
		]
	
	hideEmptyColumns altn_values_dt
	
	$('input.toggle_dt_column').click ->
		$(this).attr(
			'checked',
		  toggleColumn altn_values_dt, parseInt($(this).data()['index'])
		)
	
