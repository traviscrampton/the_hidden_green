TheHiddenGreen.Views.InvestmentForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitInvestmentForm'
	},

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['investments/investment_form']);
	},

	submitInvestmentForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Investment({
			name: $('#name').val(),
			amount: $('#amount').val(),
			interest_rate: $('#interest_rate').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitInvestmentForm', "investments")
		    },
		    error: function (model, response) {
		        console.log("error");
		    }
		});
	}
})
