TheHiddenGreen.Views.AccountList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerAccountForm'
	},

	initialize: function(){
		this.listenToOnce(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Account.prototype, 'deleteItem', this.clickedTrashCan)
		this.listenTo(TheHiddenGreen.Views.Account.prototype, 'editItem', this.clickedPencil)
	},

	render: function(){
		this.$el.append(JST['accounts/account_list']);
		this.collection.each(this.renderAccount, this);
	},

	renderAccount: function(account){
		this.$el.append(new TheHiddenGreen.Views.Account({
			model: account,
			className:'itemContainer'
		}).el);
	},

	triggerAccountForm: function(){
		this.trigger('triggerAccountForm')
	},

	clickedTrashCan: function(model){
		this.trigger('deleteItem', model)
	},

	clickedPencil: function(model){
		this.trigger('editItem', model)
	}


})
