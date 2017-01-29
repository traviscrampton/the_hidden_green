TheHiddenGreen.Views.Calendar = Backbone.View.extend({

	initialize: function(){
		this.render()
	},

	render: function(){
		this.monthsCollection = new TheHiddenGreen.Collections.Months(calendar.months)
		this.months = new TheHiddenGreen.Views.MonthList({
			collection: this.monthsCollection
		})
		this.$el.append(this.months.el)
	}
})
