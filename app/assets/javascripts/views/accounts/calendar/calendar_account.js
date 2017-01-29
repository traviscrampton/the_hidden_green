TheHiddenGreen.Views.CalendarAccount = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['accounts/calendar_account']({account: this.model}))
	}
})
