TheHiddenGreen.Views.IncomeForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitIncomeForm',
		'click .submit_update': 'updateIncomeForm'
	},

	initialize: function(options){
		this.render();
		if(options.model){
			this.populateUpdateForm(options.model)
			this.changeUpdateButton();
		}
	},

	render: function(){
		this.$el.html(JST['incomes/income_form']);
	},

	populateUpdateForm: function(model){
		this.$el.find('input#name').val(model.attributes.source_name)
		this.$el.find('input#amount').val(model.attributes.source_amount)
	},

	changeUpdateButton(){
		this.$el.find('.submit').removeClass('submit').addClass('submit_update')
	},

	submitIncomeForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Income({
			source_name: $('input#name').val(),
			source_amount: $('input#amount').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitIncomeForm', "income")
		    },
		    error: function (model, response) {
		        console.log(response);
		    }
		});
	},

	updateIncomeForm: function(){
		var attributes = {
			source_name: $('#name').val(),
			source_amount: $('#amount').val()
		}
		this.model.save(attributes, {patch: true})
		this.trigger('submitIncomeForm', "income")
	}
})
