# JS for Coding frames
@VALENCY or= {}

# dataTable settings
dtapi = $.fn.dataTableExt.oApi # see custom_data_table_plugins.js
ns    = @VALENCY.global

# returns a sorter function for Coding frame column: ignore the badge
sort_ignoring_label = (iCol) ->
  (src, type, val) ->
    if type is 'sort'
      return dtapi.MAX unless src[iCol]
      $(src[iCol]).text().trim().replace(/\s+/g,' ').substr(1)
    else
      if type is 'set' then src[iCol] = val else src[iCol]


oDTSettings_index = 
  sDom: "<'row'<'span4'i><'span8'f>>t" # no scrolling
  # sScrollY: "700px"
  bPaginate: false
  oLanguage:
    sInfoFiltered: " (filtered)"
    sSearch: ""
  aoColumnDefs: [ # 0: Coding frame, 1: derived, 2: arg_count,
                  # 3: verb_count,   4: Verb meanings & Verbs
    {
      aTargets:[0] # Coding frame
      sType: "html"
      asSorting: ['asc']
      mDataProp: sort_ignoring_label 0
    },{
      aTargets:[3] # verb_count
      asSorting: ['desc', 'asc']
    },{
      aTargets:[4] # Verb meanings & Verbs
      sType: 'html'
      sWidth: '60%'
      mDataProp: dtapi._sorter_fn_empty_last 4
      asSorting: []
    }
  ]
  aaSorting: [[3,'desc'], [0,'asc']]
    


@VALENCY.coding_frames =
  
  init: ->
  
    
  index: ->
    $cf_list = $('#coding_frames_list')
    $dt      = $cf_list.dataTable $.extend(ns.oDTSettings, oDTSettings_index)
    
    $('td.columns').each -> $(this).children().inColumns 3
    
  
  show: ->
    $verb_list = $('#verb_list')
    $dt = $verb_list.dataTable $.extend(ns.oDTSettings, {
      sDom: "<'row'<'span4'i><'span4'f>>t"
      bPaginate: false
      oLanguage:
        sInfoFiltered: " (filtered)"
        sSearch: ""
      aoColumnDefs: [ # 0: Verb form, 1: Meanings
        {
          aTargets: [0, 1]
          sType: 'html'
        }
      ]
      aaSorting: [[1, 'asc']]
    })
  
