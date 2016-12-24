TheHiddenGreen.Views.IncomeForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitIncomeForm'
	},

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['incomes/income_form']);
	},

	submitIncomeForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Income({
			source_name: $('#name').val(),
			source_amount: $('#amount').val(),
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitIncomeForm', "income")
		    },
		    error: function (model, response) {
		        console.log("error");
		    }
		});
	}
})
