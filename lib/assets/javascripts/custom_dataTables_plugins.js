/*
 * Plugins for smooth DataTables interaction
 * Depends on DataTables v 1.9.2
 */
(function($) {
	/*
	 * hides the column indexed iColumnIndex
	 */
	$.fn.dataTableExt.oApi.hideColumn = function(oSettings, iColumnIndex) {
		// this refers to the DataTable instance
		this.fnSetColumnVis(iColumnIndex, false);
	};
	
	/*
	 * shows the column indexed iColumnIndex
	 */
	$.fn.dataTableExt.oApi.showColumn = function(oSettings, iColumnIndex) {
		// this refers to the DataTable instance
		this.fnSetColumnVis(iColumnIndex, true);
	};
	
	/*
	 * toggles visibility of the column indexed iColumnIndex
	 */
	$.fn.dataTableExt.oApi.toggleColumn = function(oSettings, iColumnIndex) {
		// this refers to the DataTable instance
		this.fnSetColumnVis(iColumnIndex, !oSettings.aoColumns[iColumnIndex].bVisible);
	};
	
	/*
	 * hides all columns marked as .empty (via class) 
	 */
	
	
})(jQuery);
