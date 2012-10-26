# JS for Verbs
@VALENCY or= {}

altn_occurs_sort_order =
	'Regularly' :'A'
	'Marginally':'B'
	'Never'     :'C'

oDTSettings = 
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
					altn_occurs_sort_order[src[1]] || "Z"
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
	

@VALENCY.verbs =
	init: ->
		
	
	index: ->
		$('#verbs_list').dataTable
			"sDom": "<'row'<'span4'i><'span8'f>>tS"
			"sScrollY": "700px"
			"oLanguage":
				"sInfoFiltered": " (filtered)"
				"sSearch": "Filter:"
		# specific to /verbs index page
	
	show: ->
		@setup_reveal_below()
		altn_values_dt = $('#alternation_values_list').dataTable oDTSettings
		altn_values_dt.mytest();
	
	setup_reveal_below: ->
		$('div.reveal-me').hide()
		$('a.reveal-below').click ->
			$concealed = $(this).parent().next '.reveal-me'
			$(this).slideUp 30, ->
				$concealed.slideToggle()
		
# hide all columns with class "empty"
hideEmptyColumns = (datatable) ->
	datatable.find?('thead th').each (index, el) ->
		hideColumn(datatable, index) if $(el).hasClass('empty')
	
# $('input.toggle_dt_column').click ->
# 	$(this).attr(
# 		'checked',
# 	  toggleColumn altn_values_dt, parseInt($(this).data()['index'])
# 	)
	
