TheHiddenGreen.Models.Income = Backbone.Model.extend({
	url:'/incomes'
});

TheHiddenGreen.Collections.Incomes = Backbone.Collection.extend({
  url: '/incomes',
  model: TheHiddenGreen.Models.Income

});
