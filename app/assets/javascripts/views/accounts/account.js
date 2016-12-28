TheHiddenGreen.Views.Account = Backbone.View.extend({

	events:{
		'click .deleteItem': 'clickedTrashCan'
	},

  initialize: function(){
    this.render();
		this.listenTo(this.model, 'destroy', this.removeAccountItem);
  },

  render: function(){
    this.$el.html(JST['accounts/account']({account: this.model}));
  },

	clickedTrashCan: function(){
		this.trigger('deleteItem', this)
	},

	removeAccountItem: function(model){
		this.$el.fadeOut('fast');
	}

});
