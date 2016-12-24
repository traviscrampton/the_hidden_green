TheHiddenGreen.Views.AccountList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerAccountForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
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
	 }
})
