TheHiddenGreen.Views.MonthlySpendingForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitMonthlySpendingForm',
		'click .submit_update': 'updateMonthlySpendingForm'
	},

	initialize: function(options){
		this.render();
		if(options.model){
			this.populateUpdateForm(options.model)
			this.changeUpdateButton();
		}
	},

	render: function(){
		this.$el.html(JST['monthly_spendings/monthly_spending_form']);
	},

	populateUpdateForm: function(model){
		this.$el.find('input#rent').val(model.get('rent')),
		this.$el.find('input#food').val(model.get('food')),
		this.$el.find('input#phone').val(model.get('phone')),
		this.$el.find('input#utilities').val(model.get('utilities')),
		this.$el.find('input#everything_else').val(model.get('everything_else'))
	},

	changeUpdateButton(){
		this.$el.find('.submit').removeClass('submit').addClass('submit_update')
	},

	submitMonthlySpendingForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.MonthlySpending({
			rent: this.$el.find('input#rent').val(),
			food: this.$el.find('input#food').val(),
			phone: this.$el.find('input#phone').val(),
			utilities: this.$el.find('input#utilities').val(),
			everything_else: this.$el.find('input#everything_else').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitMonthlySpendingForm', "spending")
		    },
		    error: function (model, response) {
		        console.log(response);
		    }
		});
	},

	updateMonthlySpendingForm: function(){
		var attributes = {
			rent: this.$el.find('input#rent').val(),
			food: this.$el.find('input#food').val(),
			phone: $('input#phone').val(),
			utilities: this.$el.find('input#utilities').val(),
			everything_else: this.$el.find('input#everything_else').val()
		}
		this.model.save(attributes, {patch: true})
		this.trigger('submitMonthlySpendingForm', "spending")
	}
})
