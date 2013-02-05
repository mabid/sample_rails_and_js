class Vocallocal.Collections.Comments extends Backbone.Collection

  model: Vocallocal.Models.Comment

  url: ->
    "/businesses/#{Vocallocal.currentViewing}/posts/#{@post_id}/comments.json"


  initialize: ()->
    @post_id = arguments[1].post_id

     
