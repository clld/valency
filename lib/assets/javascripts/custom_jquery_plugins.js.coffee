###
# some project-specific jQuery plugins for interactive UI
# written in CoffeeScript
# requires jQuery v 1.7.2 or higher
###
(($) ->
	# inColumns jQuery Plugin
	# by Alexander Jahraus
	# usage: $('li').inColumns(nCols);
	# 
	# counts n elements and wraps them
	# in nCols <div>s evenly (n/nCols items per <div>)
	# tailored to work with Bootstrap's .dropdown-menu
	$.fn.inColumns = (nCols) ->
		# this is a collection of <li> nodes
		return this if (nItems = @length) < nCols
		perCol     = Math.ceil( nItems / nCols )
		# slice and wrap:
		totalWidth = i = 0
		while i < nCols
			($thisCol = @slice perCol * i, perCol * ++i).wrapAll '<div class="column"/>'
		# adjust widths: temporarily show dropdown (invisible)
		($menu = $thisCol.closest '.dropdown-menu').css display: 'block', opacity: 0
		# Firefox hack: add 1 pixel...
		$menu.width(1 + $menu.children('.column').toArray().reduce(
			(sum, next) ->
				sum + $(next).outerWidth()
			, 0)
		).children('li').not('.divider').width $menu.find('.column:first').outerWidth()
		$menu.css display: '', opacity: '' # reset display and opacity
		this
	
	# align_below_and_setup_toggle jQuery Plugin
	# by Alexander Jahraus
	# usage: $obj.align_below_and_setup_toggle()
	# find the immediately following element, align it directly below this
	# and set a slideToggle handler on click, updating the label of this
	$.fn.align_below_and_setup_toggle = ->
		$btn       = this
		$toggle_me = $btn.next() # could add optional selector here
		$parent    = $toggle_me.parent()
		offset     = $btn.offset()
		
		return this if $toggle_me.length < 1
		
		$toggle_me.offset
			'left': offset.left
			'top' : offset.top + $btn.outerHeight()
		.css
			'max-width': '600px'
			'min-width': '200px'
		.hide()
		
		$btn.click ->
			$toggle_me.slideToggle 200, ->
				label = $btn.text()
				$btn.text label.replace(
					/(hide|show)/, if label.match(/hide/) then "show" else "hide"
				)
		this
		
	# shows only the first (@arg max) elements of the collection. Wraps the remaining ones
	# in a hidden <div> and includes a link to toggle it. The link gives the number of
	# hidden items
	$.fn.show_first = (max=1, css_class='', wrapper=null) ->
		return this unless max < @length
		$parent = this.parent() # container of all the elements
		$rest = @slice(max).hide()
		[text_show, text_hide] = ["show #{$rest.length} more…", "show less"]
		$link = $("<a class='#{css_class}'/>").text(text_show).click ->
			$rest.each -> $(this).fadeToggle 300, ->
				$link.text(if $rest.last().is ':visible' then text_hide else text_show)
		$link.insertAfter($parent)
		$link.wrap wrapper if wrapper?		
	
	# flash: highlight an element for duration milliseconds
	# by toggling a class that changes background-color
	$.fn.flash = (color_class = 'flash-yellow', duration = 300) ->
    _it      = this # the jQuery object to flash
    _it.queue((next) -> _it.addClass(color_class); next())
       .queue((next) -> _it.delay(duration); next())
       .queue((next) -> _it.removeClass(color_class); next())
  
)(jQuery)