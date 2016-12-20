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

		this.currentWindow = new TheHiddenGreen.Views.ContentView({
			el: '#contentView'
		})
	},

	selectFinancial: function(data){
		this.currentWindow.remove();
		var viewHash = {
			'debts': this.getDebts,
			'savings': this.getSavings,
			'investments': this.getInvestments,
			'income': this.getIncome,
			'spending': this.getSpending
		}
		viewHash[data].call();
	},

	getDebts: function(){
		alert('You Hit Debts')
	},

	getSavings: function(){
		alert('you hit savings')
	},

	getInvestments: function(){
		alert('you hit investments')
	},

	getIncome: function(){
		alert('you hit income')
	},

	getSpending: function(){
		alert('you hit spending')
	}
})
