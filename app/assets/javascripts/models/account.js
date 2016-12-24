TheHiddenGreen.Models.Account = Backbone.Model.extend({
	url:'/accounts'
});

TheHiddenGreen.Collections.Accounts = Backbone.Collection.extend({
  url: '/accounts',
  model: TheHiddenGreen.Models.Account

});
