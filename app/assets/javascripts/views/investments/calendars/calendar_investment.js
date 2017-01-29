TheHiddenGreen.Views.CalendarInvestment = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['investments/calendar_investment']({investment: this.model}))
	}
})
