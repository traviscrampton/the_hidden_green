TheHiddenGreen.Models.Investment = Backbone.Model.extend({
	url:'/investments'
});

TheHiddenGreen.Collections.Investments = Backbone.Collection.extend({
  url: '/investments',
  model: TheHiddenGreen.Models.Investment
});
