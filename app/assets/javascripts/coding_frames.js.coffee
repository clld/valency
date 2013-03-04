# JS for Coding frames
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
	# sScrollY: "700px"
	aoColumnDefs: [ # 0: Coding frame, 1: derived, 2: arg_count,
									# 3: verb_count,	 4: Verb meanings & Verbs
		{
			aTargets:[0] # Coding frame
			sType: "html"
			asSorting: ['asc','desc']
			mDataProp: ns.coding_frame_sorter(0)
		},{
			aTargets:[3] # verb_count
			asSorting: ['desc', 'asc']
		},{
			aTargets:[4] # Verb meanings & Verbs
			sType: 'html'
			sWidth: '60%'
			mDataProp: dtapi._sorter_fn_empty_last 4
			asSorting: []
		}
	]
	aaSorting: [[3,'desc'], [0,'asc']]
		


@VALENCY.coding_frames =
	init: ->
		
	index: ->
		$cf_list = $('#coding_frames_list')
		$dt			= $cf_list.dataTable $.extend(ns.oDTSettings, oDTSettings_index)
		
		$('td.columns').each -> $(this).children().inColumns 3
		
		$(".idx-no.free").hover -> $(@).toggleClass 'label'
		
	
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
		
		@index_numbers = $(".coding_frame:not(.no-hover) .idx-no.free")
		@index_numbers.click ->
			n = $(this).data('idx-no')
			$("th[data-idx-no=#{n}],td[data-idx-no=#{n}]").flash()
		$("th[data-idx-no], td[data-idx-no]").hover ->
			$(this).toggleClass 'outline'
			n = $(this).data('idx-no')
			$(".coding_frame:not(.no-hover) .idx-no.free[data-idx-no=#{n}]").toggleClass 'label'
			
