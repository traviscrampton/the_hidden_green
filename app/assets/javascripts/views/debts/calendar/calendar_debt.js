TheHiddenGreen.Views.CalendarDebt = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['debts/calendar_debt']({debt: this.model}))
	}
})
