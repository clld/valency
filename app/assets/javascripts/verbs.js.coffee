# activate jquery.dataTable for fixed-width containers, see http://is.gd/MWVT9G
# with Scroller enabled, see http://datatables.net/extras/scroller/
# "iDisplayLength": 20 -- show 20 entries per page
# "sPaginationType": "bootstrap" -- use bootstrap plugin to style pagination links
setup_toggle_comment = ->
	$btn_toggle_comment = $('#verb_toggle_commment')
	$verb_comment = $('#verb_comment')

	return unless offset = $btn_toggle_comment.offset()
	parent = $verb_comment.parent()
	$verb_comment.offset
		'left': offset.left
		'top' : offset.top + $btn_toggle_comment.outerHeight()
	.css 'width',
			 parent.width() - (offset.left - parent.offset().left)
	.hide()

	$btn_toggle_comment.click ->
		$this = $(this)
		$verb_comment.slideToggle ->
			$this.text(
				if $this.text().match(/show.*/)
				then "hide comment" else "show comment"
			)

setup_reveal_below = ->
	$('div.reveal-me').hide()
	$('a.reveal-below').click ->
		$concealed = $(this).parent().next('.reveal-me')
		$(this).slideUp 30, ->
			$concealed.slideToggle()

altn_occurs_sort_order =
	"Regularly" :"A"
	"Marginally":"B"
	"Never"     :"C"
	
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
	setup_toggle_comment()
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
	
	hideEmptyColumns altn_values_dt
	
	$('input.toggle_dt_column').click ->
		$(this).attr(
			'checked',
		  toggleColumn altn_values_dt, parseInt($(this).data()['index'])
		)
	
