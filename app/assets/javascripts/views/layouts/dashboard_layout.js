TheHiddenGreen.Views.DashboardLayout = Backbone.View.extend({

	initialize: function(){
		this.render();
		this.renderSubViews();
	},


	render: function(){
		this.$el.html(JST['layouts/dashboard']);
	},

	renderSubViews: function(){
		this.navbar = new TheHiddenGreen.Views.Navbar({
			el: '#navbar'
		});

		this.commandCenter = new TheHiddenGreen.Views.CommandCenter({
			el: '#commandCenter'
		});
	}

})
