###
# some useful jQuery dataTables plugins for smooth DataTables interaction
# written in CoffeeScript
# requires DataTables v 1.9.2
###
(($) ->
	api = $.fn.dataTableExt.oApi # namespace
	################## utility methods #################################
	# get valid column index by title or index
	# @param mCol: integer or string (column title)
	# @returns: undefined if no column found or index invalid
	api.getColumnIndex = (oSettings, mCol) ->
		type = typeof mCol
		cols = oSettings.aoColumns
		return mCol if type == "number" and mCol > -1 and mCol < cols.length
		if type == "string" and mCol isnt ""
			mCol = mCol.toLowerCase()
			for col, i in cols
				return i if col.sTitle.toLowerCase() is mCol
		undefined
	
	api.filterColumn = (oSettings, mCol, sTerm, bRegex=true) ->
		true
	
	################## showing and hiding columns ######################
	# hide a column by index or title
	api.hideColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		@fnSetColumnVis mCol, false if mCol?
	
	# show a column by index or title
	api.showColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		@fnSetColumnVis mCol, true if mCol?
	
	# toggle visibility of a column by index or title
	api.toggleColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		@fnSetColumnVis(mCol, not oS.aoColumns[mCol].bVisible) if mCol?
	
	# if amCols is undefined or equals "all": show all columns
	# @param amCols (optional): array of column indexes or titles (can be mixed)
	api.showColumns = (oSettings, amCols = "all") ->
		if amCols is "all"
			@fnSetColumnVis(mCol, true) for mCol in [0 ... oSettings.aoColumns.length]
		else
			@showColumn mCol for mCol in amCols
	
#################################################
)(jQuery)
