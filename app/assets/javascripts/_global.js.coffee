# Garber-Irish technique, see http://mrkp.me/1v
# or this blog post (for Rails): http://is.gd/JChU9E

# global VALENCY object holds page-specific Javascript code
@VALENCY or= {}

@VALENCY.global =
	init: ->
		# object caching
		@language_dropdown or= $('#language_dropdown')
		@meaning_dropdown  or= $('#meaning_dropdown')
		@submenu or= $('#submenu')
		
		# shift body down by height of navbar
		$(document.body).css 'padding-top', $('.navbar-fixed-top').outerHeight()
		
		# show dropdown menus in columns (see custom jQuery plugin)
		@language_dropdown.find('.dropdown-menu .divider').nextAll().inColumns 3
		@meaning_dropdown.find( '.dropdown-menu .divider').nextAll().inColumns 5
		
		# setup button to toggle the comment box below it – see custom jQuery plugins
		$('.toggle-next').align_below_and_setup_toggle()
		
		# align submenu with language name / dropdown
		@submenu.offset left: @language_dropdown.offset().left
				
		# prevent .disabled links from firing
		$('.disabled').click (e) -> e.preventDefault()
	

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