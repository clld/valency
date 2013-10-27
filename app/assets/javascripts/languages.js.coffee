# JS for Languages
@VALENCY or= {}

### utitilies for gmaps4rails interactions
###
yellow_circle = "/assets/cf60.png"
red_circle    = "/assets/c00d.png"

switch_on  = (marker) ->
  marker.serviceObject.setIcon red_circle
switch_off = (marker) ->
  marker.serviceObject.setIcon yellow_circle unless marker.selected
showInfoWindow = (marker) ->
  marker.infowindow.open(Gmaps.map.serviceObject, marker.serviceObject)
  @infowindow_is_open = true
hideInfoWindow = (marker) ->
  marker.infowindow.close()
  @infowindow_is_open = false
markerForLanguageId = (lang_id) ->
  Gmaps.map.markers.filter((el) -> el.id is lang_id)[0]
markersForRegionId  = (region_id) ->
  Gmaps.map.markers.filter((el) -> el.region is region_id)
  

@VALENCY.languages =
  init: ->
    
  
  index: ->
    @setup_map_interactions()
  
  show: ->
    
  
  setup_map_interactions: ->
    $('.language').hover(
      -> switch_on( markerForLanguageId(@id)),
      -> switch_off(markerForLanguageId(@id))
    ).click ->
      $this  = $(this)
      marker = markerForLanguageId @id
      $this.toggleClass 'selected'
      if $this.hasClass 'selected'
        showInfoWindow marker; marker.selected = true
      else
        hideInfoWindow marker; marker.selected = false
    
    $('[id^="region"]').click ->
      $this   = $(this)
      markers = markersForRegionId @id
      $this.toggleClass 'selected'
      if $this.hasClass('selected')
        markers.forEach (m) -> m.selected = true; switch_on(m)
      else
        markers.forEach (m) -> m.selected = false; switch_off(m)
      
    
  



