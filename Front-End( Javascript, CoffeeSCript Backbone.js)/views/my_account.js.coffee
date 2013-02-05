class Vocallocal.Views.MyAccountArea extends Backbone.View

  el: "#account-detail"

  template: JST['users/my_account']

  initialize: ->
    _.bindAll(@, 'render')
    @render()

  render: ->
    @$el.html(@template(user: Vocallocal.currentUser))
    @
