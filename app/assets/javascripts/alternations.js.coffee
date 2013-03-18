# JS for Alternations
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global

# sort by alternation name, not by the 'C' or 'U' badge
sort_by_altn_name = (iCol) ->
	(src, type, val) ->
		if type is 'sort'
			return 'zzz' unless src[iCol]
			console.log($(src[iCol]).find('span:not(.label)').text())
			$(src[iCol]).find(':not(.label)').text?()
		else
			if type is 'set' then src[iCol] = val else src[iCol]


oDTSettings_index = 
  sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
  aoColumnDefs: [ # 0: Altn name, 1: coded? , 2: Description, 3: example, 4: verb count 
    {
      aTargets:[0] # Altn name
      sType: "html"
      sWidth: '20%'
    },{
      aTargets:[2] # Description
      sType: "html"
      sWidth: '30%'
    },{
      aTargets:[3] # Example
      sType: "html"
      sWidth: '45%'
    },{
      aTargets:[4] # verb count
      asSorting: ['desc','asc']
    }
  ]
  aaSorting: [[0,'asc']]

oDTSettings_show = 
  sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
  aoColumnDefs: [ # 0: Meaning, 1: Verb , 2: occurs, 3: arg_count,
                  # 4: basic CF, 5: derived CF, 6: arg_count_derived, 7: example(true) 
    {
      aTargets:[0, 1, 2, 4, 5] 
      sType: "html"
    },{
      aTargets:[4, 5]
      sWidth: '30%'
    },{
      aTargets:[0] # Meaning
      sWidth: '5%'
    },{
      aTargets:[1] # Verb form
      sWidth: '10%'
    },{
      aTargets:[2] # occurs
      mDataProp: ns.sort_by_data_attr(2)
      sWidth: '5%'
    }
  ]
  aaSorting: [[0,'asc']]


@VALENCY.alternations =
  init: ->
    
  
  index: ->
    $altn_list = $('#altn_list')
    $dt        = $altn_list.dataTable $.extend true, ns.oDTSettings, oDTSettings_index
    $dt.setCustomSortFunction 'alternation name', sort_by_altn_name
    $dt.sortEmptyLast 'description', 'examples'
    
  
  show: ->
    $av_list = $('#av_list')
    $dt      = $av_list.dataTable $.extend true, ns.oDTSettings, oDTSettings_show
    $dt.sortEmptyLast 'basic coding frame', 'derived coding frame' # this screws up handlers for CFIN highlighting!
    $('.dataTable tbody').on('hover', '.coding_frame:not(.no-hover) .idx-no', ->
      n = $(this).data('idx-no')
      $(this).closest('tr').find(".idx-no[data-idx-no=#{n}]").toggleClass 'label'      
    )
  
