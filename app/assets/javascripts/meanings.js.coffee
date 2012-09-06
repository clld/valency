# activate jquery.dataTable for fixed-width containers, see http://is.gd/MWVT9G
# with Scroller enabled, see http://datatables.net/extras/scroller/
# "iDisplayLength": 20 -- show 20 entries per page
# "sPaginationType": "bootstrap" -- use bootstrap plugin to style pagination links

$(document).ready ->
	$('#meanings_table').dataTable
		"sDom": "<'row'<'span4'i><'span8'f>>tS"
		"sScrollY": "730px"
		"bPaginate": true
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"

