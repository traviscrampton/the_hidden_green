TheHiddenGreen.Views.Income = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeIncomeItem);
  },

  render: function(){
    this.$el.html(JST['incomes/income']({income: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	removeIncomeItem: function(model){
		this.$el.fadeOut('fast');
	}

});
