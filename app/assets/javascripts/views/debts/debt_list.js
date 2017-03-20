TheHiddenGreen.Views.DebtList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerDebtForm'
	},

	initialize: function(){
		this.listenToOnce(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Debt.prototype, 'deleteItem', this.clickedTrashCan)
		this.listenTo(TheHiddenGreen.Views.Debt.prototype, 'editItem', this.clickedPencil)
	},

	render: function(){
		this.$el.append(JST['debts/debt_list']);
		this.collection.each(this.renderDebt, this);
	},

	renderDebt: function(debt){
		this.$el.append(new TheHiddenGreen.Views.Debt({
			model: debt,
			className:'itemContainer'
		}).el);
	},

	triggerDebtForm: function(){
		this.trigger('debtForm')
	},

	clickedTrashCan: function(model){
		this.trigger('deleteItem', model)
	},

	clickedPencil: function(model){
		this.trigger('editItem', model)
	}


})
