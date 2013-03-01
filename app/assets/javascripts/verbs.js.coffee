# JS for Verbs
@VALENCY or= {}

ns  = @VALENCY.global
max = $.fn.dataTableExt.oApi.MAX

sort_order =
	'R' : 'A'
	'M' : 'B'
	'N' : 'C'

altn_occurs_sort_order = (html) ->
  html = html.replace(/[\n\s]/g,'').replace(/<.*?>/g,'')
  sort_order[html] or max
	
# pad an integer with zeros from left to make a string like 000123 
# source: http://stackoverflow.com/a/7254108/1030985
padWithZeros = (num, max_len) ->
	(1e9 + num + "").slice -max_len
	
# returns custom sorting method for the mDataProp of the "Examples" column:
# the column will be sorted by example number instead of example text
sort_by_example_number = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return max unless src[iCol]
			text = $(src[iCol]).text()
			num = parseInt(text.match(/\d+/)[0]) if /\d+/.test(text)
			padWithZeros (num or 99999), 6
		else
			if type is 'set' then src[iCol] = val else src[iCol]
	
# returns a sorting method for the Alternation name column:
# sort by alternation name, not by the 'C' or 'U' badge
sort_by_altn_name = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return max unless src[iCol]
			$(src[iCol]).find(':not(.label)').text?()
		else
			if type is 'set' then src[iCol] = val else src[iCol]
	
# dataTable settings
oDTSettings = 
	sDom: "<'row'<'span4'i><'span8'f>>t"
	aaSorting: [[1,'asc'], [0,'asc']] # "Regularly" first, then alphabetically
	# custom column settings
	# colums: 0:altn_name, 1:occurs, 2:comment, 3:coded, 4:derived_cf, 5:example
	aoColumnDefs: [
		{
			aTargets:[0,1,2,4,5]
			sType: "html"
		},{
			aTargets: [1] # column 1: Occurs
			sWidth  : '1%'
			mDataProp: ( src, type, val ) ->
				return altn_occurs_sort_order(src[1]) if type is 'sort'
				if type is 'set' then src[1] = val else src[1]
		},{
			aTargets: [0] # alternation name
			sWidth  : "33%"
		},{
			aTargets: [2] # comment
			sWidth  : "15%"
		},{
  		aTargets: [2, 4, 5] # comment, dcf, examples
  		asSorting:['asc']
  	},{
			aTargets: [3] # coded? – always hide
			bVisible: false
		},{
			aTargets: [4] # derived coding frame
			sWidth  : '20%'
		},{
			aTargets : [5] # examples
			sWidth   : "50%"
		}
	]
	

@VALENCY.verbs =
	init: ->
		
	
	index: ->
		$('#verbs_list').dataTable $.extend(
			ns.oDTSettings,
			{
				sDom: "<'row'<'span4'i><'span8'f>>tS"
				sScrollY: "700px"
				aoColumnDefs: [
				  {
            aTargets:[3] # Coding frame
            sType: "html"
            asSorting: ['asc','desc']
            mDataProp: ns.coding_frame_sorter(3)
				  }
				]
			}
		)
	
	show: ->
		$('.examples-container').each -> 
			$(this).children().show_first(1, 'btn btn-mini')
		
		$dt = $('#av_list').dataTable $.extend(
			ns.oDTSettings, oDTSettings)
		
		$dt.sortEmptyLast('examples', 'derived coding frame', 'comment')
		
		# sort examples in dataTable by example number
		$dt.setCustomSortFunction 'examples', sort_by_example_number
		$dt.setCustomSortFunction 'alternation name', sort_by_altn_name
		
		# initialize popover for Alternation names
		$('.cell a[rel="popover"]').popover({
		  placement: 'right'
		})
		  
