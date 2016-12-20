TheHiddenGreen.Views.CommandCenter = Backbone.View.extend({

	initialize: function(){
		this.setupEvents();
		this.render();
		this.renderSubViews();
	},

	setupEvents: function(){
		this.listenTo(TheHiddenGreen.Views.NavigationButtons.prototype, 'selectFinancial', this.selectFinancial);
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
	},

	selectFinancial: function(data){
		this.trigger('selectFinancial', data)
	}
})
