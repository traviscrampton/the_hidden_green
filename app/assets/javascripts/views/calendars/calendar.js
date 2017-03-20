TheHiddenGreen.Views.Calendar = Backbone.View.extend({

	initialize: function(){
		this.setupEvents();
		this.render()
	},

	setupEvents: function(){
		this.listenTo(TheHiddenGreen.Views.MonthList.prototype, 'upToCalendar', this.renderModal)
	},

	render: function(){
		this.$el.append(JST['layouts/calendar'])
		this.renderMonths();
	},

	renderMonths: function(){
		this.monthsCollection = new TheHiddenGreen.Collections.Months(calendar.months)
		this.months = new TheHiddenGreen.Views.MonthList({
			collection: this.monthsCollection
		})
		this.$el.find('.full__calendar').append(this.months.el)
	},

	renderModal: function(model){
		this.modalMonth = new TheHiddenGreen.Views.ZoomedMonth({
			model: model
		})
		this.$el.append(this.modalMonth.el);
	}
})
