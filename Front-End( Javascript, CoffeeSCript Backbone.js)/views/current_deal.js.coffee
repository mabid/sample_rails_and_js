class Vocallocal.Views.CurrentDeal extends Backbone.View

  template: JST['businesses/current_deal']

  tagName : 'tr'
  className: 'current-deal'

  events:
    "click a.edit"   : "editDeal"
    "click a.preview"   : "previewDeal"
    "click a.end"   : "disableDeal"

  afterDisable: ->
    console.log "after Disable Called"
    Vocallocal.vent.trigger("deals:reload")
    
  disableDeal: ->
    @model.disable(@afterDisable)

  editDeal: ->
    Vocallocal.vent.trigger("deal:edit", @model)

  previewDeal: ->
    console.log "came to preview deal"
    Vocallocal.vent.trigger("deal:preview", @model)

  initialize: ->
    _.bindAll(@, 'close', 'afterDisable', 'render', 'editDeal', 'previewDeal')
    @model.on "clean_up", @close

  close: ->
    @unbind()
    @$el.remove()

  render :->
    @$el.html(@template(deal: @model))
    @
