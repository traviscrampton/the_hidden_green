TheHiddenGreen.Views.MonthlySpending = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan',
		'click .editItem': 'clickedPencil'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeMonthlySpendingItem);
  },

  render: function(){
    this.$el.append(JST['monthly_spendings/monthly_spending']({monthly_spending: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	clickedPencil: function(){
		this.trigger('editItem', this.model)
	},

	removeMonthlySpendingItem: function(model){
		this.$el.fadeOut('fast');
	}

});
