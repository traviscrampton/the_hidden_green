TheHiddenGreen.Views.DebtForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitDebtForm'
	},

	initialize: function(options){
		this.render();
		if(options.model){
			this.populateUpdateForm(options.model)
		}
	},

	render: function(){
		this.$el.html(JST['debts/debt_form']);
	},

	populateUpdateForm: function(model){
		debugger;
	},

	submitDebtForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Debt({
			name: $('#name').val(),
			amount: $('#amount').val(),
			interest_rate: $('#interest_rate').val(),
			minimum_monthly_payment: $('#minimum_monthly_payment').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitDebtForm', "debts")
		    },
		    error: function (model, response) {
		        console.log(response);
		    }
		});
	}
})
