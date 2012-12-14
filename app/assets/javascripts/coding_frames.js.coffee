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
                  # 3: verb_count,   4: Meaning labels & Verbs
    {
      aTargets:[0] # Coding frame
      sType: "html"
      asSorting: ['asc']
      mDataProp: sort_ignoring_label 0
    },{
      aTargets:[3] # verb_count
      sType: 'numeric'
      asSorting: ['desc', 'asc']
    },{
      aTargets:[4] # Meaning labels & Verbs
      sType: 'html'
      sWidth: '60%'
      mDataProp: dtapi._sorter_fn_empty_last 4
    }
  ]
  aaSorting: [[0,'asc'], [1,'asc']]
    


@VALENCY.coding_frames =
  
  init: ->
  
    
  index: ->
    $cf_list = $('#coding_frames_list')
    $dt      = $cf_list.dataTable $.extend(ns.oDTSettings, oDTSettings_index)
    
    item_height = $('.isotope').first().children().first().outerHeight() or 20
    $('.isotope').each (i, container) ->
      $container  = $(container)
      $children   = $container.children()
      item_count  = $children.length
      cols        = if $container.width() < 420 then 2 else 3
      items_per_col = Math.ceil(item_count / cols)
      $children.filter(":nth-child(n + #{items_per_col + 1})").css 'margin-left', '2em'
      $container.height( items_per_col * item_height )
      .isotope
        animationEngine: 'css'
        layoutMode: 'fitColumns'
    
  
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
  
