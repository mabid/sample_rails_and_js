class Vocallocal.Models.PhotoFile extends Backbone.Model
  url: ->
    "/businesses/#{Vocallocal.currentViewing}/photos/#{@id}.json"
