TheHiddenGreen.Views.DebtList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerDebtForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Debt.prototype, 'deleteItem', this.clickedTrashCan)
	},

	render: function(){
		this.$el.append(JST['debts/debt_list']);
		this.debts = this.collection.each(this.renderDebt, this);
	},

	renderDebt: function(debt){
		this.$el.append(new TheHiddenGreen.Views.Debt({
			model: debt,
			className:'itemContainer'
		}).el);
	},

	removeSubViews: function(){
		debugger;
		// _.each(this.debts, function(d){d.remove()})
	},

	triggerDebtForm: function(){
		this.trigger('triggerDebtForm')
	},

	clickedTrashCan: function(debtItem){
		this.trigger('deleteItem', debtItem)
	}


})
