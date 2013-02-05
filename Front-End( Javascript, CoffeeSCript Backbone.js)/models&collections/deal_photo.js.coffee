class Vocallocal.Models.DealPhoto extends Backbone.Model

  url: ->
    "/businesses/#{Vocallocal.currentViewing}/deals/#{@collection.deal_id}/deal_photos/#{@id}.json"
