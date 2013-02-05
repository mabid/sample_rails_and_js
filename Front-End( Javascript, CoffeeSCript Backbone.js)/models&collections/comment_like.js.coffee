class Vocallocal.Models.CommentLike extends Backbone.Model

  url: ->
    if @isNew()
      "/businesses/#{Vocallocal.currentBusiness.id}/posts/#{@collection.post_id}/comments/#{@collection.comment_id}/comment_likes.json"
    else
      "/businesses/#{Vocallocal.currentBusiness.id}/posts/#{@collection.post_id}/comments/#{@collection.comment_id}/comment_likes/#{@id}.json"

  userUrl: (method)->
    if method=="delete"
      "/users/#{Vocallocal.currentUser.id}/posts/#{@collection.post_id}/comments/#{@collection.comment_id}/comment_likes/#{@id}.json"
    else
      "/users/#{Vocallocal.currentUser.id}/posts/#{@collection.post_id}/comments/#{@collection.comment_id}/comment_likes.json"
    
  sync: (method, model, options)->
    if((method=='create' || method=='delete') && Vocallocal.currentUser)
      options.url = model.userUrl(method)
      model.set 'business_id', Vocallocal.currentViewing
    
    return Backbone.sync(method, model, options)
