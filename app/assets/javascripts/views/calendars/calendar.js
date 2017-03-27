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
		var self = this;
		model.fetch({
			data:{
				id: model.id
			},
			success: function(model, response, options){
				// self.monthModel = new TheHiddenGreen.Models.Month(model)
				self.activeModal = new TheHiddenGreen.Views.ZoomedMonth({
					model: model
				})
				self.$el.append(self.activeModal.el);
			}, error: function(model, response, options){
				console.log(response)
			}

		})
	}
})
