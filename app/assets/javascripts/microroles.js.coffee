# JS for Microroles
@VALENCY or= {}

dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns		= @VALENCY.global

# returns custom sorting method for the mDataProp of the "Microrole" column:
# using Microrole#sort_prefix, Original roles are to be sorted before new roles
sort_microroles = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return max unless src[iCol]
			$(src[iCol]).data('sort-prefix') + src[iCol]
		else
			if type is 'set' then src[iCol] = val else src[iCol]


# dataTable settings for Microroles index
oDTSettings_index = 
	sDom: "<'row'<'span8'i><'span4'f>>t"
	# 0: microrole name, 1: meaning label, 2: original_or_new,
	# 3: N verbs in M languages, 4: CF count, 5: core_or_additional, 6: verb_count
	aoColumnDefs: [
		{
			aTargets:[4] # Coding frame count
			sType: 'numeric'
			asSorting:['desc','asc']
		},{
			aTargets:[0,1] # microrole name, meaning label
			sType: 'html'
		},{
			aTargets:[3] # N verbs in M languages
			aDataSort: [6]
			asSorting:['desc','asc']
		},{
			aTargets:[6] # verb_count (hidden)
			sType: 'numeric'
		},{
			aTargets:[1] # meaning label
			sWidth: '20%'
		},{
			aTargets:[0] # Microrole
			mDataProp: sort_microroles 0
		}
	]
	aaSorting: [[1, 'asc'], [0, 'asc']] # sort by meaning label, then microrole

# dataTable settings for single Microrole
oDTSettings_show = 
	sDom: "<'row'<'span4'i><'span8'f>>t"
	aoColumnDefs: [				 # 0: Language				 # 5: derived,
		{										 # 1: region					 # 6: arg_count
			aTargets:[0,3,4,8,9]# 2: family					 # 7: index number
			sType:'html'				# 3: verb form			 # 8: coding set
													# 4: coding frame		 # 9: argument type
		} 
											 
	]
	
	

@VALENCY.microroles =
	init: ->
	
	index: ->
		$dt = $('#microroles_list').dataTable $.extend true, ns.oDTSettings, oDTSettings_index
	
	show: ->
		$('.dataTable').dataTable $.extend ns.oDTSettings, oDTSettings_show
		