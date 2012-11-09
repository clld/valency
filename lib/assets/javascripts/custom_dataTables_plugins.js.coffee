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
	
	# filter a column by a regex pattern such as "this|that"
	# @param mCol column index or title
	# to reset all filters, use API plugin method fnFilterClear
	api.filterColumn = (oSettings, mCol, sTerm, bRegex=true) ->
		mCol = @getColumnIndex(mCol)
		if mCol?
			@fnFilter sTerm, mCol, bRegex
			true
	
	################## showing and hiding columns ######################
	# hide a column by index or title
	api.hideColumn = (oS, mCol) ->
		mCol = @getColumnIndex(mCol)
		if mCol?
			@fnSetColumnVis mCol, false
			false # return column's new visibility
	
	# show a column by index or title
	api.showColumn = (oSettings, mCol, withflash = true) ->
		mCol = @getColumnIndex(mCol)
		if mCol?
			@fnSetColumnVis mCol, true
			$(oSettings.aoColumns[mCol].nTh).flash?() if withflash
			true # return column's new visibility
	
	# hide several columns
	api.hideColumns = (oS, cols...) ->
		@hideColumn @getColumnIndex mCol for mCol in cols
	
	# toggle visibility of a column by index or title
	api.toggleColumn = (oSettings, mCol, withflash = true) ->
		mCol = @getColumnIndex(mCol)
		if mCol?
			visible = oSettings.aoColumns[mCol].bVisible
			if visible
				@hideColumn(mCol)
			else
				@showColumn(mCol, withflash)
	
	# if amCols is undefined or equals "all": show all columns
	# @param amCols (optional): array of column indexes or titles (can be mixed)
	api.showColumns = (oSettings, amCols = "all") ->
		if amCols is "all"
			@fnSetColumnVis(i, true) for mCol, i in oSettings.aoColumns
			true for i in oSettings.aoColumns
		else
			@showColumn mCol for mCol in amCols
	
	# @param mCol: column index or title
	api.isVisible = (oSettings, mCol) ->
		mCol = @getColumnIndex(mCol)
		oSettings.aoColumns[mCol].bVisible if mCol?
	
#################################################
)(jQuery)
