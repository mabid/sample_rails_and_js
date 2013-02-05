class Vocallocal.Views.DealsView extends Backbone.View

  el: "#sidebar"

  emptyTemplate: JST['businesses/no_deal']

  initialize: ->
    _.bindAll(@, 'refetch', 'render')
    @deals = new Vocallocal.Collections.Deals
    @deals.status = 'current'
    @deals.bind 'reset', @render
    @deals.fetch()

  refetch: ->
    @deals.fetch()

  render: ->
    @$el.html('')
    if @deals.models.length==0
      @$el.html(@emptyTemplate())
    else
      for deal in @deals.models
        dealView = new Vocallocal.Views.DealBox model: deal
        @$el.append(dealView.render().$el)
    Vocallocal.vent.trigger("deals_loaded")


    
