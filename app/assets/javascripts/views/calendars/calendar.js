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
		var furl = model.urlRoot + "/" + model.id.toString();
		var self = this;
		$.ajax({
			url: furl,
			method:'GET',
			success: function(data){
				self.monthModel = new TheHiddenGreen.Models.Month(data)
				self.activeModal = new TheHiddenGreen.Views.ZoomedMonth({
					model: self.monthModel,
					data: data
				})
				self.$el.append(self.activeModal.el);
			},
			error: function(data){
				console.log(data)
			}
		})
	}
})
