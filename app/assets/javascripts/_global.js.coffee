# Garber-Irish technique, see http://mrkp.me/1v
# or this blog post (for Rails): http://is.gd/JChU9E

# global VALENCY object holds page-specific Javascript code
@VALENCY or= {}

@VALENCY.global =
	init: ->
		# these are defined in custom_jquery_plugins
		$('#language_dropdown .dropdown-menu .divider').nextAll().inColumns(3)
		$('.toggle-next').align_below_and_setup_toggle()
	
@VALENCY.util = 
	

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
		controller = data.controller
		window.UTIL.exec "global"     # controller-independent initialization
		window.UTIL.exec controller   # controller-specific stuff
		window.UTIL.exec controller, data.action # action-specific stuff
		
		# $(document).trigger('finalized'); # for super low-priority tasks
	

# trigger on DOM ready
$(document).ready @UTIL.init