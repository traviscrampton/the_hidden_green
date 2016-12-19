TheHiddenGreen.Views.Navbar = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['layouts/navbar']);
	}
})
