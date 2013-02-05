class Vocallocal.Models.Photo extends Backbone.Model
  url: ->
    "/businesses/#{Vocallocal.currentViewing}/photos/#{@id}.json"
