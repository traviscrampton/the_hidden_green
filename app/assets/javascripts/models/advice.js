TheHiddenGreen.Models.Advice = Backbone.Model.extend({
	urlRoot:'/advices'
});

TheHiddenGreen.Collections.Advices = Backbone.Collection.extend({
  url: '/advices',
  model: TheHiddenGreen.Models.Advice

});
