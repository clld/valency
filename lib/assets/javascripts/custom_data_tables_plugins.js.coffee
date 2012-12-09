###
# some useful jQuery dataTables plugins for smooth DataTables interaction
# written in CoffeeScript
# requires DataTables v 1.9.2
###

(($) ->
	api = $.fn.dataTableExt.oApi # namespace
  # utility constant: last char of basic multilingual pane
	api.MAX = String.fromCharCode 65535
	#---------------------- utility methods ---------------------------------
	# this is a necessary closure, used in the sortEmptyLast plugin
	# it makes empty table cells behave like 'zzz' when sorting
	api._sorter_fn_empty_last = (iCol) ->
  	(src, type, val) ->
  		if   type is 'sort' then (src[iCol] or api.MAX) else
  			if type is 'set'  then  src[iCol] = val   else src[iCol]
	
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
		null # default to null: allows checking with `dataTableInstance.getColumnIndex('colname')?`
	
	# uses the plugin setCustomSortFunction to set up column sorting
	# to sort empty cells last for each of the passed columns
	api.sortEmptyLast = (oSettings, cols...) ->
		for col in cols
			@setCustomSortFunction col, api._sorter_fn_empty_last
	
	# sets the sort function of column mCol to be the result
	# returned by 
	api.setCustomSortFunction = (oSettings, mCol, fnSorter) ->
		if (iCol = @getColumnIndex(mCol))? and
		typeof fnSorter is 'function' and
		typeof (fn = fnSorter iCol) is 'function'
			oColOpts = { mDataProp: fn }
			# call internal API method to update column options
			oSettings.oApi._fnColumnOptions( oSettings, iCol, oColOpts )
	
	# filter a column by a regex pattern such as "this|that"
	# @param mCol column index or title
	# to reset all filters, use API plugin method fnFilterClear
	api.filterColumn = (oSettings, mCol, sTerm, bRegex=true) ->
		if (mCol = @getColumnIndex(mCol))?
			@fnFilter sTerm, mCol, bRegex
			true
	
	#--------------------------------- showing and hiding columns ---------------------------------
	# hide a column by index or title
	api.hideColumn = (oS, mCol) ->
		if (mCol = @getColumnIndex(mCol))?
			@fnSetColumnVis mCol, false
			false # return column's new visibility
	
	# show a column by index or title
	api.showColumn = (oSettings, mCol, withflash = true) ->
		if (mCol = @getColumnIndex(mCol))?
			@fnSetColumnVis mCol, true
			$(oSettings.aoColumns[mCol].nTh).flash?() if withflash
			true # return column's new visibility
	
	# hide several columns
	api.hideColumns = (oS, cols...) ->
		@hideColumn @getColumnIndex mCol for mCol in cols
	
	# toggle visibility of a column by index or title
	api.toggleColumn = (oSettings, mCol, withflash = true) ->
		if (mCol = @getColumnIndex(mCol))?
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
		if (mCol = @getColumnIndex(mCol))?
			oSettings.aoColumns[mCol].bVisible
			
	# check if the column is empty
	api.isEmpty = (oSettings, mCol) ->
    if (mCol = @getColumnIndex(mCol))?
      oSettings.aoData.every (oRow) ->
        oRow._aData[mCol] in ["", null, undefined]
	
	#--------------------------------- change pagination / scrolling to show particular row 
	# plugin by Allan Jardine
	# @params nRow must be a DOM node object, *not* a jQuery object.
	api.fnDisplayRow = (oSettings, nRow) ->
		dispLen = oSettings._iDisplayLength
		return this if dispLen is -1
		# Find the node in the table
		iPos = -1
		for displayIndex, i in oSettings.aiDisplay
			if oSettings.aoData[ displayIndex ].nTr is nRow
				iPos = i
				break
		if iPos >= 0 # Alter the start point of the paging display
			oSettings._iDisplayStart = Math.floor(i / dispLen) * dispLen
			oSettings.oApi._fnCalculateEnd oSettings
		oSettings.oApi._fnDraw oSettings
	
#--------------------------------------------------------------------
)(jQuery)
