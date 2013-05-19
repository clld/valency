# JS for Coding frames
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

oDTSettings_index = 
	sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
	aoColumnDefs: [ # 0: Coding frame, 1: derived, 2: arg_count,
									# 3: verb_count,	 4: Verb meanings & Verbs
		{
			aTargets:[0] # Coding frame
			sType: "html"
			asSorting: ['asc','desc']
			sWidth: "30%"
			mDataProp: ns.coding_frame_sorter(0)
		},{
			aTargets:[3] # verb_count
			asSorting: ['desc', 'asc']
			sWidth: "10%"
		},{
			aTargets:[4] # Verb meanings & Verbs
			sType: 'html'
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
		
		@index_numbers = $(".coding_frame:not(.no-hover) .idx-no")
		@index_numbers.click ->
			n = $(this).data('idx-no')
			$("th[data-idx-no=#{n}],td[data-idx-no=#{n}]").flash()
		$("th[data-idx-no], td[data-idx-no]").hover ->
			$(this).toggleClass 'outline'
			n = $(this).data('idx-no')
			$(".coding_frame:not(.no-hover) .idx-no[data-idx-no=#{n}]").toggleClass 'label'

		# set up hover highlighting for Coding frame index numbers
		# TODO duplicated from Verbs for now; refactor to reuse!
		$(".coding_frame.padded-box:not(.no-hover) .idx-no").hover ->
			n = $(this).data('idx-no')
			$("tr[data-idx-no=#{n}]").toggleClass('outline').find('th').removeClass('outline')
		$("tr[data-idx-no]").hover ->
			n = $(this).data('idx-no')
			$(this).find('th').toggleClass 'outline'
			$("th[data-idx-no=#{n}]").toggleClass 'outline'
			$(".coding_frame:not(.no-hover) .idx-no[data-idx-no=#{n}]").toggleClass 'label'
		.click -> 
			n = $(this).data('idx-no')
			$(".coding_frame.padded-box:not(.no-hover) .idx-no[data-idx-no=#{n}]").flash('flash-green')
	
