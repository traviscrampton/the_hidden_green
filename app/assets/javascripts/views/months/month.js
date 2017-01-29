TheHiddenGreen.Views.Month = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['months/month']({calendar: this.model }))
	}
})
