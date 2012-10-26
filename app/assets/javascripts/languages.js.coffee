# JS for Languages
@VALENCY or= {}

@VALENCY.languages =
	init: ->
		
	index: ->
		$('#languages_list').dataTable
			"sDom": "<'row'<'span4'i><'span8'f>>t"
			"bPaginate": false
			"oLanguage":
				"sInfoFiltered": " (filtered)"
				"sSearch": "Filter:"
	
	show: ->
		$('#language_metadata th').css('width', '6em')
		
	



