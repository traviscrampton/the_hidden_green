TheHiddenGreen.Models.Debt = Backbone.Model.extend({

});

TheHiddenGreen.Collections.Debts = Backbone.Collection.extend({
  url: '/debts',
  model: TheHiddenGreen.Models.Debt

});
