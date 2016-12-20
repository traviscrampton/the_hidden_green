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
		this.removeCurrentWindow();
		var viewHash = {
			'debts': this.getDebts,
			'savings': this.getSavings,
			'investments': this.getInvestments,
			'income': this.getIncome,
			'spending': this.getSpending
		}
		viewHash[data].call();
	},

	removeCurrentWindow(){
		this.currentWindow.undelegateEvents();
    this.currentWindow.$el.removeData().unbind().empty();
	},

	getDebts: function(){
		this.debtsCollection = new TheHiddenGreen.Collections.Debts();
		this.currentWindow = new TheHiddenGreen.Views.DebtList({
			el: '#contentView',
			collection: this.debtsCollection,
		});
		this.debtsCollection.fetch({data: { user_id: current_user.id} });
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
