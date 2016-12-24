TheHiddenGreen.Views.AccountForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitAccountForm'
	},

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['accounts/account_form']);
	},

	submitAccountForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Account({
			name: $('#name').val(),
			amount: $('#amount').val(),
			a_type: $('#a_type').val(),
			interest: $('#interest_rate').val(),

		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitAccountForm', "savings")
		    },
		    error: function (model, response) {
		        console.log("error");
		    }
		});
	}
})
