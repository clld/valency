# activate jquery.dataTable for fixed-width containers, see http://is.gd/MWVT9G
# with Scroller enabled, see http://datatables.net/extras/scroller/
# "iDisplayLength": 20 -- show 20 entries per page
# "sPaginationType": "bootstrap" -- use bootstrap plugin to style pagination links

$(document).ready ->
	$('#verbs_list').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>tS"
		"sScrollY": "700px"
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"

	$('#alternation_values_list').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>t"
		"bPaginate": false
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"
	
	$btn_toggle_comment = $('#verb_toggle_commment')
	$verb_comment = $('#verb_comment')

	offset = $btn_toggle_comment.offset()
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

