TheHiddenGreen.Models.Account = Backbone.Model.extend({
	urlRoot:'/accounts'
});

TheHiddenGreen.Collections.Accounts = Backbone.Collection.extend({
  url: '/accounts',
  model: TheHiddenGreen.Models.Account

});
