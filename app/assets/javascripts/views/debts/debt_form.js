TheHiddenGreen.Views.DebtForm = Backbone.View.extend({

	events:{
		'click .submit' : 'submitDebtForm',
		'click .submit_update': 'updateDebtForm'
	},

	initialize: function(options){
		this.model = options.model
		this.render();
		if(this.model){
			this.populateUpdateForm()
			this.changeUpdateButton();
		}
	},

	render: function(){
		this.$el.html(JST['debts/debt_form']);
	},

	populateUpdateForm: function(){
		this.$el.find('input#name').val(this.model.get('name'))
		this.$el.find('input#amount').val(this.model.get('amount'))
		this.$el.find('input#interest_rate').val(this.model.get('interest_rate'))
		this.$el.find('input#minimum_monthly_payment').val(this.model.get('minimum_monthly_payment'))
	},

	changeUpdateButton(){
		this.$el.find('.submit').removeClass('submit').addClass('submit_update')
	},

	submitDebtForm: function(){
		var self = this;
		var newModel = new TheHiddenGreen.Models.Debt({
			name: self.$el.find('input#name').val(),
			amount: self.$el.find('input#amount').val(),
			interest_rate: self.$el.find('input#interest_rate').val(),
			minimum_monthly_payment: self.$el.find('input#minimum_monthly_payment').val()
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
			name: this.$el.find('#name').val(),
			amount: this.$el.find('#amount').val(),
			interest_rate: this.$el.find('#interest_rate').val(),
			minimum_monthly_payment: this.$el.find('#minimum_monthly_payment').val()
		}
		this.model.save(attributes, {patch: true})
		this.trigger('submitDebtForm', "debts")
	}
})
