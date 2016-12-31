TheHiddenGreen.Views.AccountForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitAccountForm',
		'click .submit_update': 'updateAccountForm'
	},

	initialize: function(options){
		this.render();
		if(options.model){
			this.populateUpdateForm(options.model)
			this.changeUpdateButton();
		}
	},

	render: function(){
		this.$el.html(JST['accounts/account_form']);
	},

	populateUpdateForm: function(model){
		this.$el.find('input#name').val(model.attributes.name)
		this.$el.find('input#amount').val(model.attributes.amount)
		this.$el.find('input#interest_rate').val(model.attributes.interest_rate)
		this.$el.find('#a_type').val(model.attributes.a_type)
	},

	changeUpdateButton(){
		this.$el.find('.submit').removeClass('submit').addClass('submit_update')
	},

	submitAccountForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Account({
			name: $('input#name').val(),
			a_type: $('input#a_type').val(),
			amount: $('input#amount').val(),
			interest_rate: $('input#interest_rate').val(),
			a_type: $('#a_type').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitAccountForm', "savings")
		    },
		    error: function (model, response) {
		        console.log(response);
		    }
		});
	},

	updateAccountForm: function(){
		var attributes = {
			name: $('#name').val(),
			amount: $('#amount').val(),
			interest_rate: $('#interest_rate').val(),
			a_type: $('#a_type').val()
		}
		this.model.save(attributes, {patch: true})
		this.trigger('submitAccountForm', "savings")
	}
})
