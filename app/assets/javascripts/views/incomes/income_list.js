TheHiddenGreen.Views.IncomeList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerIncomeForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Income.prototype, 'deleteItem', this.clickedTrashCan)
	},

	render: function(){
		this.$el.html(JST['incomes/income_list']);
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

	clickedTrashCan: function(incomeItem){
		this.trigger('deleteItem', incomeItem)
	}


})
