# activate jquery.dataTable for fixed-width containers, see http://is.gd/MWVT9G
# with Scroller enabled, see http://datatables.net/extras/scroller/
# "iDisplayLength": 20 -- show 20 entries per page
# "sPaginationType": "bootstrap" -- use bootstrap plugin to style pagination links

$(document).ready ->
	$('#verbs_list.dataTable').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>tS"
		"bPaginate": false
		"sScrollY": "600px"
		"bDeferRender": true
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"

	$('#alternation_values_list').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>t"
		"bPaginate": false
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"
			
	$btn_vtc = $('#verb_toggle_commment')   # vtc is for verb_toggle_comment
	$('#verb_toggle_commment').click ->
		null
	
