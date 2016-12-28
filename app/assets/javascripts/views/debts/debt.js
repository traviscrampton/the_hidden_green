TheHiddenGreen.Views.Debt = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeDebtItem);
  },

  render: function(){
    this.$el.append(JST['debts/debt']({debt: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	removeDebtItem: function(model){
		this.$el.fadeOut('fast');
	}

});
