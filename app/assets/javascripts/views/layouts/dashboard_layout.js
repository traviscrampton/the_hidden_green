TheHiddenGreen.Views.DashboardLayout = Backbone.View.extend({

	initialize: function(){
		this.setupEvents();
		this.render();
		this.renderSubViews();
	},

	setupEvents: function(){
		// this.listenTo(TheHiddenGreen.Views.CommandCenter.prototype, 'selectFinancial', this.selectFinancial);
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
	},

	selectFinancial: function(data){
		debugger;
	}

})
