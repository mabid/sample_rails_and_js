class Vocallocal.Collections.DealPayments extends Backbone.Collection

  model: Vocallocal.Models.DealPayment

  url: ->
    "businesses/#{Vocallocal.currentViewing}/payments.json"

  total: ->
    tot = 0.0
    for model in @models
      tot = tot + model.get('amount_due')
    tot

