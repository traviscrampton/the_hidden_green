TheHiddenGreen.Views.CalendarDebtList = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.collection.each(this.renderDebt, this)
	},

	renderDebt: function(debt){
		this.$el.append(new TheHiddenGreen.Views.CalendarDebt({
			model: debt
		}).el)
	}
})
