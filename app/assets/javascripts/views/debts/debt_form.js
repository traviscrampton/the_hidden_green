TheHiddenGreen.Views.DebtForm = Backbone.View.extend({

	events:{
		'submit form#debt_form' : 'submitDebtForm'
	},
	
	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['debts/debt_form']);
	},

	submitDebtForm: function(){
		debugger;
	}
})
