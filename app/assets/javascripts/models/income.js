TheHiddenGreen.Models.Income = Backbone.Model.extend({
	urlRoot:'/incomes'
});

TheHiddenGreen.Collections.Incomes = Backbone.Collection.extend({
  url: '/incomes',
  model: TheHiddenGreen.Models.Income

});
