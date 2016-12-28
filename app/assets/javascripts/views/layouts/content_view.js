TheHiddenGreen.Views.ContentView = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		$('#contentView').html(JST['layouts/content_view']);
	}
})
