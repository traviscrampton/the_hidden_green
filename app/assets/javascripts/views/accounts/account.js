TheHiddenGreen.Views.Account = Backbone.View.extend({
	events:{
		'click .deleteItem': 'clickedTrashCan',
		'click .editItem': 'clickedPencil'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeAccountItem);
  },

  render: function(){
    this.$el.append(JST['accounts/account']({account: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	clickedPencil: function(){
		this.trigger('editItem', this.model)
	},

	removeAccountItem: function(model){
		this.$el.fadeOut('fast');
	}

});
