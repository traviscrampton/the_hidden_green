TheHiddenGreen.Models.Income = Backbone.Model.extend({

});

TheHiddenGreen.Collections.Incomes = Backbone.Collection.extend({
  url: '/incomes',
  model: TheHiddenGreen.Models.Income

});
