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
        # checkboxes
        $container.find('.toggle-col').each ->
        	$checkbox = $(this)
        	$labelfor = $("label[for=#{$checkbox.attr 'id'}]")
        	$label    = if $labelfor.length then $labelfor else $checkbox.closest 'label' 
        	col = $checkbox.data().col
        	if $dt.isEmpty(col)    # empty column
        	  $dt.hideColumn col
        		$checkbox.add($label).addClass('disabled')
        		  .attr 'title', 'no data in this column'
        	$checkbox.attr('checked', $dt.isVisible col)
          .click -> # checkbox click handler
            unless $checkbox.hasClass('disabled')
      	      $checkbox.attr 'checked', $dt.toggleColumn col
        
        # filter buttons
        $container.find('.filter-col').click (event)-> 
        	$btn    = $(event.target)
        	$group  = $(this) # the .btn-group to filter a column
        	column  = $group.data().col
        	strings = $btn.siblings('.active').get().map (sibling) ->
        		$(sibling).val() || $(sibling).text()
        	console.log "strings of siblings: "+strings.toString()	
        	strings.push $btn.val() || $btn.text() unless $btn.is '.active'
        	console.log("filter by: #{strings.join '|'}")
        	$dt.filterColumn column, strings.join('|')
        
        # link to clear the column filters
        $container.find('.clear-filters').click ->
          $dt.fnFilterClear()
          $container.find('.filter-col .btn').removeClass 'active'
        
        # move the .dataTables_filter div into the .dt-filters div
        $container.find('.dataTables_filter').detach()
        .appendTo $container.find('.dt-filters')

	
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