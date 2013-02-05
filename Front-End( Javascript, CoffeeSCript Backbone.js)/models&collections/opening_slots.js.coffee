class Vocallocal.Collections.OpeningSlots extends Backbone.Collection

  model: Vocallocal.Models.OpeningSlot

  url: ->
    "/businesses/#{Vocallocal.currentViewing}/opening_slots.json"

  add: (object, options)->
    console.log(arguments)
    if (_.isArray(object) || !object.get('errors'))
      Backbone.Collection.prototype.add.call(this, object, options)
    else
      @trigger('overlap_error', object)

  allClosed: ->
    for slot in @models
      if !(slot.get 'closed')
        return false
    true
        

