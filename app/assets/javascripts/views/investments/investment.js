TheHiddenGreen.Views.Investment = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeInvestmentItem);
  },

  render: function(){
    this.$el.html(JST['investments/investment']({investment: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	removeInvestmentItem: function(model){
		this.$el.fadeOut('fast');
	}

});
