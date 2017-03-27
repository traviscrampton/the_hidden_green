TheHiddenGreen.Views.MonthList = Backbone.View.extend({

	initialize: function(){
		this.setupEvents();
		this.render();
	},

	setupEvents: function(){
		this.listenTo(TheHiddenGreen.Views.Month.prototype, 'clickedMonth', this.sendToCalendar)
	},

	render: function(){
		this.collection.each(this.renderMonth, this)
	},

	renderMonth: function(month){
		debugger;
		this.$el.append(new TheHiddenGreen.Views.Month({
			model: month
		}).el)
	},

	sendToCalendar: function(model){
		this.trigger('upToCalendar', model)
	}
})
