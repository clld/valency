(function($) {
	/*
	inColumns jQuery Plugin
	by Alexander Jahraus
	usage: $('li').inColumns(nCols);
	
	counts n elements and wraps them
	in nCols <div>s evenly (n/nCols items per <div>)
	tailored to work with Bootstrap's .dropdown-menu
	*/
	$.fn.inColumns = function(nCols) {
		// "this" is a jQuery collection
		var nItems = this.length;
		if (nItems < nCols) { return this; }
		var perCol = Math.ceil(nItems/nCols),
				totalWidth = 0,
				$thisCol, $dropdown_menu;

		for (var i = 0; i < nCols; i++) {
			$thisCol = this.slice(perCol * i, perCol * (i+1));
			$thisCol.wrapAll('<div class="column"/>');
		}
		// adjusting the widths
		$dropdown_menu = $thisCol.closest('.dropdown-menu');
		// show (invisible) dropdown menu to calculate its width
		$dropdown_menu.css({display:'block', opacity:0})
			.width(1 + // Firefox hack...
				$dropdown_menu.children('.column').toArray().reduce(
					function(sum, next){return sum + $(next).outerWidth();}, 0
				)
			).children('li').not('.divider').width(
				$dropdown_menu.find('div:first').outerWidth()
			);
		// set width of <li>s outside columns to that of 1st column
		$dropdown_menu.css({display:'',opacity:''}); // reset its CSS

		return this;
	};
	
	/*
	align_below_and_setup_toggle jQuery Plugin
	by Alexander Jahraus
	usage:  align_below_and_setup_toggle()
	will find next element that matches selector, align it
	immediately below this, and set a slideToggle handler on click,
	updating the label of this
	*/
	$.fn.align_below_and_setup_toggle = function() {
		var $btn       = this,
				$toggle_me = $btn.next(),
				$parent    = $toggle_me.parent(),
				offset     = $btn.offset();
		if ($toggle_me.length < 1) return this;

		$toggle_me.offset({
			'left': offset.left,
			'top' : offset.top + $btn.outerHeight()
		}).css({
			'max-width': $parent.width() - offset.left + $parent.offset().left,
			'min-width': "200px"
		}).hide();
		
		$btn.click(function(){
			$toggle_me.slideToggle(function(){
				var label = $btn.text();
				$btn.text(label.replace(/(hide|show)/,
									label.match(/hide/)? "show": "hide")
								 );
			});
		});
		
		return this;
	};
	
})(jQuery);



