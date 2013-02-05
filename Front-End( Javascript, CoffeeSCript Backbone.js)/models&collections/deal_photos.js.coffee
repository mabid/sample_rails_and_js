class Vocallocal.Collections.DealPhotos extends Backbone.Collection

  model: Vocallocal.Models.DealPhoto

  url: ->
    "businesses/#{Vocallocal.currentViewing}/deals/#{@deal_id}/deal_photos.json"
