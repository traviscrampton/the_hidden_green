TheHiddenGreen.Models.Account = Backbone.Model.extend({

});

TheHiddenGreen.Collections.Accounts = Backbone.Collection.extend({
  url: '/accounts',
  model: TheHiddenGreen.Models.Account

});
