TheHiddenGreen.Views.MonthlySpendingList = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['monthly_spendings/monthly_spending'])
	}


})
