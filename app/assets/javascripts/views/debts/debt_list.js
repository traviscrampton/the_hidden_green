TheHiddenGreen.Views.DebtList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerDebtForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(this.model, 'destroy', this.removeDebtItem);
		this.listenTo(TheHiddenGreen.Views.Debt.prototype, 'deleteItem', this.clickedTrashCan)
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
	},

	clickedTrashCan: function(debtItem){
		this.trigger('deleteItem', debtItem)
	},

	removeDebtItem: function(model){
		this.$el.fadeOut('fast');
	}
})
