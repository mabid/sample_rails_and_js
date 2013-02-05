class Vocallocal.Collections.Photos extends Backbone.Collection

  model: Vocallocal.Models.Photo

  url: ->
    "/businesses/#{Vocallocal.currentViewing}/photos.json"
