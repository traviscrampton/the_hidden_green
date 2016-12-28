TheHiddenGreen.Models.Investment = Backbone.Model.extend({
	urlRoot:'/investments'
});

TheHiddenGreen.Collections.Investments = Backbone.Collection.extend({
  url: '/investments',
  model: TheHiddenGreen.Models.Investment
});
