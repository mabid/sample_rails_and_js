class Vocallocal.Models.SlotSettings extends Backbone.Model
  url: ->
    "/businesses/#{Vocallocal.currentViewing}/opening_slots/settings.json"
