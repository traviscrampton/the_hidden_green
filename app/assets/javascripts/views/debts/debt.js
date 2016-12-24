TheHiddenGreen.Views.Debt = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan'
	},

  initialize: function(){
    this.render();
  },

  render: function(){
    this.$el.html(JST['debts/debt']({debt: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	}

});
