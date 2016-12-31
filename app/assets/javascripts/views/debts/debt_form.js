TheHiddenGreen.Views.DebtForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitDebtForm',
		'click .submit_update': 'updateDebtForm'
	},

	initialize: function(options){
		this.render();
		if(options.model){
			this.populateUpdateForm(options.model)
			this.changeUpdateButton();
		}
	},

	render: function(){
		this.$el.html(JST['debts/debt_form']);
	},

	populateUpdateForm: function(model){
		this.$el.find('input#name')[0].defaultValue = model.attributes.name
		this.$el.find('input#amount')[0].defaultValue = model.attributes.amount
		this.$el.find('input#interest_rate')[0].defaultValue = model.attributes.interest_rate
		this.$el.find('input#minimum_monthly_payment')[0].defaultValue = model.attributes.minimum_monthly_payment
	},

	changeUpdateButton(){
		this.$el.find('.submit').removeClass('submit').addClass('submit_update')
	},

	submitDebtForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Debt({
			name: $('input#name').val(),
			amount: $('input#amount').val(),
			interest_rate: $('input#interest_rate').val(),
			minimum_monthly_payment: $('input#minimum_monthly_payment').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitDebtForm', "debts")
		    },
		    error: function (model, response) {
		        console.log(response);
		    }
		});
	},

	updateDebtForm: function(){
		var attributes = {
			name: $('#name').val(),
			amount: $('#amount').val(),
			interest_rate: $('#interest_rate').val(),
			minimum_monthly_payment: $('#minimum_monthly_payment').val()
		}
		this.model.save(attributes, {patch: true})
		this.trigger('submitDebtForm', "debts")
	}
})
