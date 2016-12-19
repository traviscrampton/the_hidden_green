TheHiddenGreen.Views.NavigationButtons = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['layouts/navigation_buttons']);
	}
})
