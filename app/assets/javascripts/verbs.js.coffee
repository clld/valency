# activate jquery.dataTable for fixed-width containers, see http://is.gd/MWVT9G

$(document).ready ->
	$('.dataTable').dataTable
		"iDisplayLength": 20
		"oLanguage":
			"sInfoFiltered": " (filtered)"
			"sSearch": "Filter:"
		"sDom": "<'row'<'span3'i><'span5'p><'span3'f>r>t"
		"sPaginationType": "bootstrap"

