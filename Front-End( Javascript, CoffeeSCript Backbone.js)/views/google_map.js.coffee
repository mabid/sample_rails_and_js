class Vocallocal.Views.GoogleMap extends Backbone.View

  initialize: ->
    _.bindAll(@, 'showInfo', 'hideInfo','selectBusiness', 'bounceMarker', 'showBusinesses', 'wajo', 'clearMarkers')
    @markers = []
    @bouncingMarker = null
#    @collection.bind "reset", @showBusinesses, @
    @drawMap()
    @infoWindow = null
    Vocallocal.vent.on("businessClicked", @bounceMarker)

  bounceMarker: (id)->
    marker = _.find(@markers, (single)->
                (single.business_id == id)
              )
    if marker
      if @bouncingMarker
        @bouncingMarker.setAnimation(null)
      marker.setAnimation(google.maps.Animation.BOUNCE)
      @bouncingMarker = marker
    else

  wajo: (newLoad = false)->
    console.log arguments
    @bounds = Gmaps.map.serviceObject.getBounds()
#    @collection.updateVisibles(@bounds)
    Vocallocal.vent.trigger("mapReady", @bounds, newLoad)

  clearMarkers: ->
    for marker in @markers
      marker.setMap(null)
    @markers = []

  showInfoWindow: ->
    console.log(log)

  hideInfo: ->
    that = @
    return ->
      if that.infoWindow
        that.infoWindow.close()
        that.infoWindow = null

  showInfo: ->
    that = @
    return ->
      if that.infoWindow
        that.infoWindow.close()
        that.infoWindow = null
      business = that.collection.get(@business_id)
      content = "<div class='article'><h2>#{business.get('name')}</h2>
      <span class='entrytype'>#{business.get('category_string')}</span><br />
      <span class='entryaddress'>#{business.get('address').without_country}</span>
      </div>"
      that.infoWindow = new google.maps.InfoWindow content: content, disableAutoPan: true
      that.infoWindow.open(Gmaps.map.serviceObject, @)

  selectBusiness: ->
    that = @
    return ->
      Vocallocal.vent.trigger("markerSelected", @business_id)
       

  showBusinesses: (newLoad = false)->
    markerImage = new google.maps.MarkerImage('/assets/pin.png')
    shadowImage = new google.maps.MarkerImage('/assets/pin_shadow.png', null, null, new google.maps.Point(0,14))
    @clearMarkers()
    coords = @collection.coords()
    i = 0
    for val in coords
      latLng = new google.maps.LatLng(val.lat, val.lng)
      @markers[i] = new google.maps.Marker(animation: null, flat: false, position: latLng, shadow: shadowImage,  icon: markerImage)
      @markers[i].business_id = val.id
      @markers[i].setMap(@map.serviceObject)
      google.maps.event.addListener(@markers[i], 'click', @selectBusiness())
      google.maps.event.addListener(@markers[i], 'mouseover', @showInfo())
      google.maps.event.addListener(@markers[i], 'mouseout', @hideInfo())
      i++
    @wajo(newLoad)

  drawMap: ->
    that = @
    Gmaps.map = new Gmaps4RailsGoogle()
    @map = Gmaps.map
    Gmaps.map.callback = ->
      google.maps.event.addListener(Gmaps.map.serviceObject, 'dragend', that.wajo )
      google.maps.event.addListener(Gmaps.map.serviceObject, 'zoom_changed', ->
        google.maps.event.addListenerOnce(Gmaps.map.serviceObject, 'bounds_changed', that.wajo)
      )
      google.maps.event.addListenerOnce(Gmaps.map.serviceObject, 'tilesloaded', that.wajo)

    Gmaps.load_map = ->
      Gmaps.map.map_options.auto_adjust = false
      Gmaps.map.map_options.auto_zoom = false
      Gmaps.map.map_options.zoom = 12
      Gmaps.map.map_options.raw.scrollwheel = false
      Gmaps.map.map_options.scaleControl = true
      Gmaps.map.map_options.mapTypeControl = false
      Gmaps.map.map_options.raw.streetViewControl = false
      Gmaps.map.map_options.container_id = "google_map_container"
      Gmaps.map.map_options.id = "googlemap"
      Gmaps.map.map_options.center_latitude = 51.495065
      Gmaps.map.map_options.center_longitude = -0.043945
      Gmaps.map.map_options.do_clustering = true
      Gmaps.map.initialize()
      Gmaps.map.callback()

    Gmaps.triggerOldOnload()
    Gmaps.loadMaps()
