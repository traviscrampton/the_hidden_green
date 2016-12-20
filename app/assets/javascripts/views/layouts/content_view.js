TheHiddenGreen.Views.ContentView = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['layouts/content_view']);
	}
})
