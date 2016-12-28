TheHiddenGreen.Views.AccountList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerAccountForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Account.prototype, 'deleteItem', this.clickedTrashCan)
	},

	render: function(){
		this.$el.html(JST['accounts/account_list']);
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

	clickedTrashCan: function(accountItem){
		this.trigger('deleteItem', accountItem)
	}


})
