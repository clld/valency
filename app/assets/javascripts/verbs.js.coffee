# JS for Verbs
@VALENCY or= {}

altn_occurs_sort_order =
	'Regularly' :'A'
	'Marginally':'B'
	'Never'     :'C'

oDTSettings = 
	"sDom": "<'row'<'span4'i><'span8'f>>t"
	"bPaginate": false
	"oLanguage":
		"sInfoFiltered": " (filtered)"
		"sSearch": "Search:"
	"aaSorting": [[1,'asc'], [0,'asc']] # "Regularly" first, then alphabetically
	# custom column settings
	# colums: 0:altn_name, 1:occurs, 2:comment, 3:coded, 4:derived_cf, 5:example
	"aoColumnDefs": [
		{
			"aTargets":[0,2,4,5]
			"sType": "html"
		},{
			"aTargets": [1] # column 1: Occurs
			"mDataProp": ( src, type, val ) ->
				return altn_occurs_sort_order[src[1]] or 'z' if type is 'sort'
				if type is 'set' then src[1] = val else src[1]
		},{
			"aTargets": [0] # alternation name
			"sWidth"  : "33%"
		},{
			"aTargets": [2] # comment
			"sWidth"  : "15%"
			'asSorting':['asc']
		},{
			'aTargets': [3] # coded? – always hide
			'bVisible': false
		},{
			'aTargets': [4] # derived coding frame
			'sWidth'  : '20%'
			'asSorting':['asc']
		},{
			"aTargets" : [5] # examples
			"sWidth"   : "50%"
			'asSorting':['asc']
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
		altn_values_dt = $('#av_list').dataTable oDTSettings
		altn_values_dt.sortEmptyLast('examples', 'derived coding frame', 'comment')
		altn_values_dt.hideColumns('derived coding frame', 'comment')
		
		# checkbox with data-column attribute "columnTitle" shall toggle that column
		$('input.toggle-dt-column').each ->
			$(this).attr 'checked', altn_values_dt.isVisible $(this).data().column
		.click ->
			$(this).attr('checked',
			  altn_values_dt.toggleColumn $(this).data().column
			)
		
		# buttons to filter dataTable by columns
		$('.dt-filters .column-filter').click (event)->
			$btn    = $(event.target)
			$group  = $(this) # the .btn-group to filter a column
			column  = $group.data().column
			strings = ( $(btn).val() || $(btn).text() for btn in $btn.siblings() when $(btn).hasClass 'active' )
			strings.push $btn.val() || $btn.text() unless $btn.hasClass 'active'
			altn_values_dt.filterColumn column, strings.join('|')
		
		# link to clear all filters
		$('.dt-filters-clear').click ->
			altn_values_dt.fnFilterClear()
			$('.dt-filters .btn').removeClass 'active'
			
		# move the .dataTables_filter div into the .dt-filters div
		$('.dataTables_filter').detach().appendTo($('.dt-filters'))
		
	setup_reveal_below: ->
		$('div.reveal-me').hide()
		$('a.reveal-below').click ->
			$concealed = $(this).parent().next '.reveal-me'
			$(this).slideUp 30, ->
				$concealed.slideToggle()
	
