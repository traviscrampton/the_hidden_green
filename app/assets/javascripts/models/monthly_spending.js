TheHiddenGreen.Models.MonthlySpending = Backbone.Model.extend({
	urlRoot:'/monthly_spendings'
});

TheHiddenGreen.Collections.MonthlySpendings = Backbone.Collection.extend({
  url: '/monthly_spendings',
  model: TheHiddenGreen.Models.MonthlySpending
});
