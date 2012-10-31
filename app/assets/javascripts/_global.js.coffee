# Garber-Irish technique, see http://mrkp.me/1v
# or this blog post (for Rails): http://is.gd/JChU9E

# global VALENCY object holds page-specific Javascript code
@VALENCY or= {}

@VALENCY.global =
	init: ->
		# object caching
		@language_dropdown = $('#language_dropdown')
		@meaning_dropdown  = $('#meaning_dropdown')
		
		# show dropdown menus in columns (see custom jQuery plugin)
		@language_dropdown.find('.dropdown-menu .divider').nextAll().inColumns 3
		@meaning_dropdown.find( '.dropdown-menu .divider').nextAll().inColumns 5
		
		# setup button to toggle the comment box below it – see custom jQuery plugins
		$('.toggle-next').align_below_and_setup_toggle()
		
		# make navbar link for current controller active
		$("header [data-controller='#{window.VALENCY.controller}']").addClass "active"
		
		# prevent .disabled links from firing; show tooltip instead
		$('.disabled').click (e) -> e.preventDefault()
		@dropdown_tooltip @language_dropdown # calls the method of global
	
	# when a .disabled .nav li item is clicked, show a tooltip
	# on the language dropdown trigger link
	dropdown_tooltip: ($menu_item) ->
		$menu_item.tooltip
			html:      false
			placement: 'bottom'
			title:     'Please choose a language'
			trigger:   'manual'
		$menu_item.mouseenter -> $menu_item.tooltip 'hide'
		$('header .nav .disabled').click =>
			$menu_item.tooltip 'show'
			window.setTimeout( =>
				$menu_item.tooltip 'hide'
			, 1200)
		
	


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