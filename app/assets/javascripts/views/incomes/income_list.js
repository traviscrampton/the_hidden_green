TheHiddenGreen.Views.IncomeList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerIncomeForm'
	},

	initialize: function(){
		this.listenToOnce(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Income.prototype, 'deleteItem', this.clickedTrashCan)
		this.listenTo(TheHiddenGreen.Views.Income.prototype, 'editItem', this.clickedPencil)
	},

	render: function(){
		this.$el.append(JST['incomes/income_list']);
		this.collection.each(this.renderIncome, this);
	},

	renderIncome: function(income){
		this.$el.append(new TheHiddenGreen.Views.Income({
			model: income,
			className:'itemContainer'
		}).el);
	},

	triggerIncomeForm: function(){
		this.trigger('triggerIncomeForm')
	},

	clickedTrashCan: function(model){
		this.trigger('deleteItem', model)
	},

	clickedPencil: function(model){
		this.trigger('editItem', model)
	}


})
