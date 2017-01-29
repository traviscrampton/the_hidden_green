TheHiddenGreen.Views.CalendarAccountList = Backbone.View.extend({

	initialize: function(){
		this.render()
	},

	render: function(){
		this.collection.each(this.renderAccounts, this)
	},

	renderAccounts: function(account){
		this.$el.append(new TheHiddenGreen.Views.CalendarAccount({
			model: account
		}).el)
	}
})
