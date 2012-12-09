# Garber-Irish technique, see http://mrkp.me/1v
# or this blog post (for Rails): http://is.gd/JChU9E

# global VALENCY object holds page-specific Javascript code
@VALENCY or= {}



@VALENCY.global =
	init: ->
		# object caching
		@body = $('body')
		@language_dropdown or= $('#language_dropdown')
		@meaning_dropdown  or= $('#meaning_dropdown')
		@submenu or= $('#submenu')
		
		# shift body down by height of navbar
		$(document.body).css 'padding-top', $('.navbar-fixed-top').outerHeight()
		
		# show dropdown menus in columns (see custom jQuery plugin)
		@language_dropdown.find('.dropdown-menu .divider').nextAll().inColumns 3
		@meaning_dropdown.find( '.dropdown-menu .divider').nextAll().inColumns 5
		
		# setup button to toggle comment box – see custom jQuery plugins
		$('.toggle-next').align_below_and_setup_toggle()
		
		# align submenu with language name / dropdown
		@submenu.offset({left: @language_dropdown.offset().left})
		  .fadeIn() if @submenu.length > 0
				
		# prevent .disabled links from firing
		@body.on 'click', '.disabled,.disabled input,.disabled .btn,.disabled a',
		  (e) -> e.preventDefault()
		
		# global settings for dataTables. These are extended in the controllers' handlers
		@oDTSettings =
      fnInitComplete: (oSettings, json) ->
        # don't allow body to shrink vertically when dataTable is filtered
        $('body').css 'min-height', $('body').height()
        
        # hide columns whose <th> is .hidden-col
        @hideColumn i for col, i in oSettings.aoColumns when col
          .nTh.className.match('hidden-col')
        
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
        	$label    = if $labelfor.length then $labelfor else $checkbox.closest 'label' 
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
        # function to apply a column filter button group
        apply_column_filter = ($button_group, event = null) ->
          column  = $button_group.data().col
          unless event # not called by event handler: collect all
            strings = $button_group.children('.active').get().map (child) ->
              $(child).val() || $(child).text().trim()
          else # called by event handler: add or remove one button
            $btn    = $(event.target)
            strings = $btn.siblings('.active').get().map (sibling) ->
              $(sibling).val() || $(sibling).text().trim()
            strings.push $btn.val() || $btn.text().trim() unless $btn.is '.active'
          console.log "Filtering \"#{column}\" by \"#{strings.join '|'}\"" # DEBUG
          $dt.filterColumn(column, strings.join '|')
        
        # apply all active filter buttons after init
        $container.find('.filter-col .active').each ->
          apply_column_filter $(this).parent() # no event!
        
        # attach event handler to .filter-col button groups
        $container.find('.filter-col').click (event)-> 
        	apply_column_filter($(this), event)
        
        # link to clear the column filters
        $container.find('.clear-filters').click ->
          $dt.fnFilterClear()
          $container.find('.filter-col .btn').removeClass 'active'
        
        # move the .dataTables_filter div into the .dt-filters div
        $container.find('.dataTables_filter')
          .detach().appendTo($container.find('.dt-filters'))          

	
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
		window.VALENCY.action     = data.action
		window.UTIL.exec "global"     # controller-independent initialization
		window.UTIL.exec window.VALENCY.controller   # controller-specific stuff
		window.UTIL.exec window.VALENCY.controller, window.VALENCY.action
		
		# $(document).trigger('finalized'); # for super low-priority tasks
	

# trigger on DOM ready
$(document).ready @UTIL.init