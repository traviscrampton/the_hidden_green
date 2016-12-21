TheHiddenGreen.Views.DebtList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerDebtForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html(JST['debts/debt_list']);
		this.collection.each(this.renderDebt, this);
	},

	renderDebt: function(debt){
		 this.$el.append(new TheHiddenGreen.Views.Debt({
			 model: debt,
			 className:'itemContainer'
		 }).el);
	 },

	 triggerDebtForm: function(){
		 this.trigger('triggerDebtForm')
	 }
})
