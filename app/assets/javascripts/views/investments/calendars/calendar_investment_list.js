TheHiddenGreen.Views.CalendarInvestmentList = Backbone.View.extend({

	initialize: function(){
		this.render()
	},

	render: function(){
		this.collection.each(this.renderInvestments, this)
	},

	renderInvestments: function(investment){
		this.$el.append(new TheHiddenGreen.Views.CalendarInvestment({
			model: investment
		}).el)
	}
})
