TheHiddenGreen.Views.DebtList = Backbone.View.extend({

	events:{
		'click .triggerDebtForm' : 'triggerDebtForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html(JST['debts/debt_list']);
		this.collection.each(this.renderDebt, this);
	},

	renderDebt: function(debt){
		 this.$el.prepend(new TheHiddenGreen.Views.Debt({
			 model: debt,
			 className:'itemContainer'
		 }).el);
	 },

	 triggerDebtForm: function(){
		 this.trigger('triggerDebtForm')
	 }
})
