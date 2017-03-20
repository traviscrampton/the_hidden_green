TheHiddenGreen.Views.MonthlySpendingList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerMonthlySpendingForm'
	},

	initialize: function(){
		this.listenToOnce(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.MonthlySpending.prototype, 'deleteItem', this.clickedTrashCan)
		this.listenTo(TheHiddenGreen.Views.MonthlySpending.prototype, 'editItem', this.clickedPencil)
	},

	render: function(){
		if(this.collection.length == 0){
			this.$el.append(JST['monthly_spendings/monthly_spendings']);
		}
		this.collection.each(this.renderMonthlySpending, this);
	},

	renderMonthlySpending: function(monthlySpending){
		this.$el.append(new TheHiddenGreen.Views.MonthlySpending({
			model: monthlySpending,
			className:'itemContainer'
		}).el);
	},

	triggerMonthlySpendingForm: function(){
		this.trigger('triggerMonthlySpendingForm')
	},

	clickedTrashCan: function(model){
		this.trigger('deleteItem', model)
	},

	clickedPencil: function(model){
		this.trigger('editItem', model)
	}
})
