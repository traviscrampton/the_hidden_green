TheHiddenGreen.Views.Investment = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan',
		'click .editItem': 'clickedPencil'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeInvestmentItem);
  },

  render: function(){
    this.$el.append(JST['investments/investment']({investment: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	clickedPencil: function(){
		this.trigger('editItem', this.model)
	},

	removeInvestmentItem: function(model){
		this.$el.fadeOut('fast');
	}

});
