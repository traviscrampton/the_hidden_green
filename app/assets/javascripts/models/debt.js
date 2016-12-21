TheHiddenGreen.Models.Debt = Backbone.Model.extend({
	url:'/debts'
});

TheHiddenGreen.Collections.Debts = Backbone.Collection.extend({
  url: '/debts',
  model: TheHiddenGreen.Models.Debt

});
