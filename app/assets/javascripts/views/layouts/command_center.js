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
		this.accountsCollection = new TheHiddenGreen.Collections.Accounts();
		this.currentWindow = new TheHiddenGreen.Views.AccountList({
			el: '#contentView',
			collection: this.accountsCollection,
		});
		this.accountsCollection.fetch({data: { user_id: current_user.id} });
	},

	getInvestments: function(){
		this.investmentCollection = new TheHiddenGreen.Collections.Investments();
		this.currentWindow = new TheHiddenGreen.Views.InvestmentList({
			el: '#contentView',
			collection: this.investmentCollection,
		});
		this.investmentCollection.fetch({data: { user_id: current_user.id} });
	},

	getIncome: function(){
		this.incomeCollection = new TheHiddenGreen.Collections.Incomes();
		this.currentWindow = new TheHiddenGreen.Views.IncomeList({
			el: '#contentView',
			collection: this.incomeCollection,
		});
		this.incomeCollection.fetch({data: { user_id: current_user.id} });
	},

	getSpending: function(){
		alert('you hit spending')
	}
})
