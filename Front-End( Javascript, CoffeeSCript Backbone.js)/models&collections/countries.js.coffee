class Vocallocal.Collections.Countries extends Backbone.Collection

  model: Vocallocal.Models.Country

  url: "/businesses/#{@business_id}/countries.json"
