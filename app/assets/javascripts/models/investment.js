TheHiddenGreen.Models.Investment = Backbone.Model.extend({

});

TheHiddenGreen.Collections.Investments = Backbone.Collection.extend({
  url: '/investments',
  model: TheHiddenGreen.Models.Investment

});
