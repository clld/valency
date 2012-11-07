###
# some useful jQuery dataTables plugins for smooth DataTables interaction
# written in CoffeeScript
# requires DataTables v 1.9.2
###

# this is a necessary closure, used in the sortEmptyLast plugin
makeDataPropFunctionFor = (iCol) ->
	(src, type, val) ->
		if type is 'sort' then (src[iCol] or 'zzz') else
			if type is 'set' then src[iCol] = val else src[iCol]

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
	
	api.sortEmptyLast = (oSettings, cols...) ->
		for col in cols
			iCol     = @getColumnIndex(col)
			oColOpts = 
				mDataProp: makeDataPropFunctionFor iCol
			# call the internal api method to update column options
			oSettings.oApi._fnColumnOptions( oSettings, iCol, oColOpts )
	
	api.filterColumn = (oSettings, mCol, sTerm, bRegex=true) ->
		true
	
	################## showing and hiding columns ######################
	# hide a column by index or title
	api.hideColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		@fnSetColumnVis mCol, false if mCol?
	
	# hide several columns
	api.hideColumns = (oS, cols...) ->
		@hideColumn @getColumnIndex mCol for mCol in cols
	
	# toggle visibility of a column by index or title
	api.toggleColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		@fnSetColumnVis(mCol, not oS.aoColumns[mCol].bVisible) if mCol?
	
	# show a column by index or title
	api.showColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		@fnSetColumnVis mCol, true if mCol?
	
	# if amCols is undefined or equals "all": show all columns
	# @param amCols (optional): array of column indexes or titles (can be mixed)
	api.showColumns = (oSettings, amCols = "all") ->
		if amCols is "all"
			@fnSetColumnVis(i, true) for mCol, i in oSettings.aoColumns
		else
			@showColumn mCol for mCol in amCols
	
#################################################
)(jQuery)
