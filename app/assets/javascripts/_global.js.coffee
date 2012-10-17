# Garber-Irish technique, see http://mrkp.me/1v
# or this blog post (for Rails): http://is.gd/JChU9E

# global VALENCY object holds page-specific Javascript code
@VALENCY or= {}

@VALENCY.global =
	init: ->
		@language_dropdown = $('#language_dropdown')
		# show language dropdown menu in columns
		@language_dropdown.find('.dropdown-menu .divider').nextAll().inColumns(3)
		# setup button to toggle the comment box below it
		$('.toggle-next').align_below_and_setup_toggle()
		# make navbar link for current controller active
		$("header [data-controller='#{window.VALENCY.controller}']")
			.addClass "active"
		# prevent links inside .disabled items from firing; show tooltip instead
		$('.disabled').add('.disabled a').click (event)->
			event.preventDefault()
		@language_dropdown_tooltip() # calls the method of global
	
	language_dropdown_tooltip: ->
		@language_dropdown.tooltip
			html:      false
			placement: 'bottom'
			title:     'Please choose a language'
			trigger:   'manual'
		$("header .nav .disabled").click =>
			console.log("line 29")
			@language_dropdown.tooltip('show').mouseenter =>
				@language_dropdown.tooltip('hide')
			window.setTimeout( =>
				@language_dropdown.tooltip('hide')
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