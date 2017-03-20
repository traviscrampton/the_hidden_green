TheHiddenGreen.Models.Month = Backbone.Model.extend({
	urlRoot:'/months'
});

TheHiddenGreen.Collections.Months = Backbone.Collection.extend({
  model: TheHiddenGreen.Models.Month
});
