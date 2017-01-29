TheHiddenGreen.Views.MonthList = Backbone.View.extend({

	initialize: function(){
		this.render()
	},

	render: function(){
		this.collection.each(this.renderMonth, this)
	},

	renderMonth: function(month){
		this.$el.append(new TheHiddenGreen.Views.Month({
			model: month
		}).el)
	}


})
