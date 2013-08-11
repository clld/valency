# Garber-Irish technique, see http://mrkp.me/1v
# or this blog post (for Rails): http://is.gd/JChU9E

# global VALENCY object holds page-specific Javascript code
@VALENCY or= {}
dtapi = $.fn.dataTableExt.oApi # access to dataTable API methods

# function to apply a .btn-group's column filter to a dataTable (@param $dt)
apply_column_filter = ($dt, $button_group, event = null) ->
	column	= $button_group.data().col
	unless event # not called by event handler: collect all
		strings = $button_group.children('.active').get().map (child) ->
			$(child).val() || $(child).text().trim()
	else # called by event handler: add or remove one button
		$btn		= $(event.target)
		strings = $btn.siblings('.active').get().map (sibling) ->
			$(sibling).val() || $(sibling).text().trim()
		unless $btn.is '.active'
			strings.push $btn.val() || $btn.text().trim()
	# console.log "Filtering \"#{column}\" by \"(#{strings.join '|'})\"" # DEBUG
	$dt.filterColumn(column, "(#{strings.join '|'})")


# the global namespace: for shared initialization code
@VALENCY.global =
	init: ->
		# object caching
		@body = $('body')
		@language_dropdown or= $('#language_dropdown')
		@meaning_dropdown	 or= $('#meaning_dropdown')
		
		# flash the "choose language" link when .disabled tab clicked
		$('#submenu').find('.nav li.disabled').click ->
			$('#choose_lang').flash "flash-navbar"
		
		# make #choose_lang link open the dropdown
		$('#choose_lang').click (e) =>
			@language_dropdown.find('.dropdown-toggle').click()
			e.stopPropagation()
		
		# show dropdown menus in columns (see custom jQuery plugin)
		@language_dropdown.find( '.dropdown-menu .divider').nextAll().inColumns 3
		@meaning_dropdown.find(  '.dropdown-menu .divider').nextAll().inColumns 5
		$('#verb_dropdown').find('.dropdown-menu .divider').nextAll().inColumns 5
		
		# setup button to toggle comment box – see custom jQuery plugins
		$('.toggle[data-toggle]').each (i,el) -> $(el).align_below_and_setup_toggle()
		
		# prevent .disabled links from firing
		@body.on 'click', '.disabled,.disabled input,.disabled .btn,.disabled a',
			(e) -> e.preventDefault()
		
		# show tooltip on Example glosses
		$('.ttip').tooltip({placement: 'bottom'})
		
		# show popover on info links (Glossary terms)
		$('a.info').popover({placement:'bottom'})
		$('body').click (event)->
			$target = $(event.target)
			$('a[rel="popover"]').not($target).popover('hide') unless $target.is('.popover *, a.info *')
		
		# Coding frame index numbers: setup hover and click handlers for highlighting
		# hover on .idx-no: toggle .hover on .idx-no with the same data-idx-no
		idx_no_selector = ".coding_frame:not(.no-hover) .idx-no"
		toggle_hover = ->
			n = $(this).data('idx-no')
			$(idx_no_selector+"[data-idx-no=#{n}]").toggleClass 'hover'
			$("tr[data-idx-no=#{n}]").toggleClass 'outline'     # table rows
			$headers = $("th[data-idx-no=#{n}]");               # table headers
			$headers.toggleClass('outline') if $headers.length
				
		$(idx_no_selector).hover toggle_hover
		
		# set up hover highlighting for Coding frame index numbers in small table
		$("tr[data-idx-no], th[data-idx-no]").hover ->
			$this = $(this)
			n = $this.data('idx-no')
			$this.find('th').add("tr[data-idx-no=#{n}]").not($this)
			.add("th[data-idx-no=#{n}]").toggleClass 'outline'
			$(".idx-no[data-idx-no=#{n}]").toggleClass 'hover'
		.click -> 
			$(".coding_frame.padded-box .idx-no[data-idx-no=#{$(this).data('idx-no')}]").flash('flash-red')
		
		
		# global settings for dataTables. These are extended in the controllers' handlers
		@oDTSettings =
			bPaginate: false
			oLanguage:
				sInfo:				 "Showing _TOTAL_" # variables: _START_, _END_, _MAX_
				sInfoFiltered: " out of _MAX_"
				sInfoPostFix:	" entries"
				sInfoEmpty: "0"
				sSearch: ""
			
			fnInitComplete: (oSettings, json) ->
				# hide columns whose <th> is .hidden
				@hideColumn i for col, i in oSettings.aoColumns when col.nTh.className.match('hidden')
				
				# setup filters and togglers
				# from the table, go up to the .dt-with-filters container
				$dt = this
				$container = $(oSettings.nTable).closest('.dt-with-filters')
				$(oSettings.nTableWrapper).find('.dataTables_filter input')
				.attr 'placeholder', 'type to search'
				
				# checkboxes
				$container.find('.toggle-col').each (index, checkbox)->
					$checkbox = $(checkbox)
					$labelfor = $("label[for=#{$checkbox.attr 'id'}]")
					$label		= if $labelfor.length then $labelfor else $checkbox.closest 'label' 
					col = $checkbox.data().col
					if $dt.isEmpty(col)
						$dt.hideColumn col
						$checkbox.add($label).addClass('disabled')
						.attr 'title', 'no data in this column'
					$checkbox.attr('checked', $dt.isVisible col)
					$checkbox.click -> # checkbox click handler
						unless $checkbox.hasClass('disabled')
							$checkbox.attr 'checked', $dt.toggleColumn $checkbox.data().col
				
				# filter buttons				
				# apply all active filter buttons after init
				$container.find('.filter-col .active').each ->
					apply_column_filter $dt, $(this).parent() # no event!
				
				# attach event handler to .filter-col button groups
				$container.find('.filter-col').click (event)-> 
					apply_column_filter $dt, $(this), event
				
				# link to clear the column filters
				$container.find('.clear-filters').click ->
					$dt.fnFilterClear()
					$container.find('.filter-col .btn').removeClass 'active'
				
				# move the .dataTables_filter div into the .dt-filters div
				$container.find('.dataTables_filter')
					.detach().appendTo($container.find('.dt-filters'))					
				
				# don't allow body to shrink vertically when dataTable is filtered
				$('body').css 'min-height', $('body').height()
				
				# highlight index numbers in the same coding frame
				$('.dataTable tbody').on(
					"mouseenter mouseleave": -> 
						$this = $(this)
						n = $this.data('idx-no')
						$this.closest('tr').find(".idx-no[data-idx-no=#{n}]").toggleClass "hover"
				,'.coding_frame .idx-no')
	### store some shared functions to reuse in other JS files ###
	
	# returns a dataTable sorter function for a Coding frames column:
	# ignore the badge; sort lower argument count first	
	coding_frame_sorter: (iCol) ->
		(src, type, val) ->
			if type is 'sort'
				return dtapi.MAX unless src[iCol]
				$html = $(src[iCol])
				$html.data('arg-count') + $html.text().trim().replace(/\s+/g,' ').substr(1)
			else
				if type is 'set' then src[iCol] = val else src[iCol]
	
	# returns a dataTable sorter function for any HTML whose first child has
	# a data-sort attribute
	sort_by_data_attr: (iCol) -> # sort by the data-sort of first child
		(src, type, val) ->
			if type is 'sort'
				$(src[iCol]).first().data('sort') || dtapi.MAX
			else
				if type is 'set' then src[iCol] = val else src[iCol]
	

# @UTIL.init calls these: 
# @VALENCY.global.init()
# @VALENCY.controller_name.init()
# @VALENCY.controller_name.action_name()
@UTIL = 
	exec: ( controller, action = "init" ) ->
		ns = window.VALENCY
		if controller isnt "" and ns[controller]
			ns[controller][action]?()
	
	init: ->
		data = $('body').data() # CAUTION: don't store too much data in the body tag
		window.VALENCY.controller = data.controller
		window.VALENCY.action		 = data.action
		window.UTIL.exec "global"		 # controller-independent initialization
		window.UTIL.exec window.VALENCY.controller	 # controller-specific stuff
		window.UTIL.exec window.VALENCY.controller, window.VALENCY.action
		
		# $(document).trigger('finalized'); # for super low-priority tasks
	

# trigger on DOM ready
$(document).ready @UTIL.init