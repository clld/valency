# JS for Verbs
@VALENCY or= {}

altn_occurs_sort_order =
	'Regularly' :'A'
	'Marginally':'B'
	'Never'     :'C'
	
# pad an integer with zeros from left to make a string like 000123 
# source: http://stackoverflow.com/a/7254108/1030985
padWithZeros = (num, max_len) ->
	(1e9 + num + "").slice -max_len
	
# returns custom sorting method for the mDataProp of the "Examples" column:
# the column will be sorted by example number instead of example text
sort_by_example_number = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return 'zzz' unless src[iCol]
			num = parseInt $(src[iCol]).find('.number').first?().text?().replace?(/\D/g,''), 10
			padWithZeros (num or 9999), 6
		else
			if type is 'set' then src[iCol] = val else src[iCol]
	
# returns a sorting method for the Alternation name column:
# sort by alternation name, not by the 'C' or 'U' badge
sort_by_altn_name = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return 'zzz' unless src[iCol]
			$(src[iCol]).find('span:not(.label)').text?()
		else
			if type is 'set' then src[iCol] = val else src[iCol]
	

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
			'sWidth'  : '10%'
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
		$('.examples-container').each -> 
			$(this).children().show_first()
		
		altn_values_dt = $('#av_list').dataTable oDTSettings
		
		# don't allow body to shrink vertically when dataTable is filtered
		$('body').css 'min-height', $('body').outerHeight() 
		
		altn_values_dt.sortEmptyLast('examples', 'derived coding frame', 'comment')
		
		# sort examples in dataTable by example number
		altn_values_dt.setCustomSortFunction 'examples', sort_by_example_number
		altn_values_dt.setCustomSortFunction 'alternation name', sort_by_altn_name
		
		altn_values_dt.hideColumns('derived coding frame', 'comment')
		
		
		# checkbox with data-column attribute "columnTitle" shall toggle that column
		$('input.toggle-dt-column').each ->
			$(this).attr 'checked', altn_values_dt.isVisible $(this).data().column
		.click ->
			$(this).attr 'checked', altn_values_dt.toggleColumn $(this).data().column 
		
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
		
