TheHiddenGreen.Views.InvestmentForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitInvestmentForm',
		'click .submit_update': 'updateInvestmentForm'
	},

	initialize: function(options){
		this.render();
		if(options.model){
			this.populateUpdateForm(options.model)
			this.changeUpdateButton();
		}
	},

	render: function(){
		this.$el.html(JST['investments/investment_form']);
	},

	populateUpdateForm: function(model){
		this.$el.find('input#name').val(model.attributes.name)
		this.$el.find('input#amount').val(model.attributes.amount)
		this.$el.find('input#interest_rate').val(model.attributes.interest_rate)
	},

	changeUpdateButton(){
		this.$el.find('.submit').removeClass('submit').addClass('submit_update')
	},

	submitInvestmentForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Investment({
			name: $('input#name').val(),
			a_type: $('input#a_type').val(),
			amount: $('input#amount').val(),
			interest_rate: $('input#interest_rate').val()
		});
		newModel.save({}, {
		    success: function (model, response) {
		      self.trigger('submitInvestmentForm', "investments")
		    },
		    error: function (model, response) {
		        console.log(response);
		    }
		});
	},

	updateInvestmentForm: function(){
		var attributes = {
			name: $('#name').val(),
			amount: $('#amount').val(),
			interest_rate: $('#interest_rate').val()
		}
		this.model.save(attributes, {patch: true})
		this.trigger('submitInvestmentForm', "investments")
	}
})
