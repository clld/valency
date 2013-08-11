# JS for Coding frames
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
	aoColumnDefs: [ # 0: Coding frame, 1: derived, 2: arg_count,
									# 3: verb_count,	 4: Verb meanings & Verbs OR: Language
		{
			aTargets:[0] # Coding frame
			sType: "html"
			asSorting: ['asc','desc']
			mDataProp: ns.coding_frame_sorter(0)
		},{
			aTargets:[3] # verb_count
			asSorting: ['desc', 'asc']
			sWidth: "10%"
		},{
			aTargets:[4] # Verb meanings & Verbs OR: Language
			sType: 'html'
			mDataProp: dtapi._sorter_fn_empty_last(4)
			asSorting: []
			sWidth: "25%"
		}
	]
	aaSorting: [[3,'desc'], [0,'asc']]


@VALENCY.coding_frames =
	init: ->
		
	index: ->
		$cf_list = $('#coding_frames_list')
		
		language_column_shown = $cf_list.data("language") is "all" 
		if language_column_shown # sort on the Language column
			oDTSettings_index.aoColumnDefs[2].asSorting.push("asc","desc") # enable
			oDTSettings_index.aaSorting = [[4,'asc']]
		
		$('td.columns').each -> $(this).children().inColumns(3)
		
		$dt = $cf_list.dataTable $.extend(ns.oDTSettings, oDTSettings_index)		
	
	show: ->
		$verb_list = $('#verb_list')
		$dt = $verb_list.dataTable $.extend(ns.oDTSettings, {
			sDom: "<'row'<'span4'i><'span4'f>>t"
			aoColumnDefs: [ # 0: Verb form, 1: Meanings
				{
					aTargets: [0, 1]
					sType: 'html'
				}
			]
			aaSorting: [[1, 'asc']]
		})
		$dt.sortEmptyLast(2,3,4,5)
		
		# flash column showing the Microroles of a Coding frame index number
		$(".coding_frame .idx-no").add("tr[data-idx-no]").click -> 
			n = $(this).data('idx-no')
			$("th[data-idx-no=#{n}],td[data-idx-no=#{n}]").flash()
	