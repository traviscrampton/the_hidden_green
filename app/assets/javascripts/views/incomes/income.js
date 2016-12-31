TheHiddenGreen.Views.Income = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan',
		'click .editItem': 'clickedPencil'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeIncomeItem);
  },

  render: function(){
    this.$el.append(JST['incomes/income']({income: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	clickedPencil: function(){
		this.trigger('editItem', this.model)
	},

	removeIncomeItem: function(model){
		this.$el.fadeOut('fast');
	}

});
