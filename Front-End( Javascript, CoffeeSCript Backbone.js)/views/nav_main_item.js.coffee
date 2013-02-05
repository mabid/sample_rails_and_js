class Vocallocal.Views.NavMainItem extends Backbone.View

  tagName: 'li'

  template: JST['nav_main_item']

  events:
    "click a.main" : "startSearch"

  startSearch: ->
    Vocallocal.vent.trigger("categoryClicked", @model.get 'name' )
    if @model.get 'everthing'
      Vocallocal.vent.trigger("doSearch", null)
    else
      Vocallocal.vent.trigger("doSearch", @model.id)
    false

  render: ->
    _.bindAll(@, 'startSearch')
    @$el.html(@template(name: @model.get('name')))
    if @model.get('sub_categories')
      subitems = new Vocallocal.Views.NavSubItems items: @model.get('sub_categories')
      @$('a').after(subitems.render().el)
    else
      @$('span.pointer').remove()
    @
