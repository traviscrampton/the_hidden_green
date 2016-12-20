TheHiddenGreen.Views.CommandCenter = Backbone.View.extend({

	initialize: function(){
		this.render();
		this.renderSubViews();
	},

	render: function(){
		this.$el.html(JST['layouts/command_center']);
	},

	renderSubViews: function(){
		this.navigationButtons = new TheHiddenGreen.Views.NavigationButtons({
			el: '#navigationButtons'
		});

		this.contentWindow = new TheHiddenGreen.Views.ContentView({
			el: '#contentView'
		})
	}
})
