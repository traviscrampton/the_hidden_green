TheHiddenGreen.Views.CommandCenter = Backbone.View.extend({

	initialize: function(){
		this.setupEvents();
		this.render();
		this.renderSubViews();
	},

	setupEvents: function(){
		this.listenTo(TheHiddenGreen.Views.NavigationButtons.prototype, 'selectFinancial', this.selectFinancial);
		this.listenTo(TheHiddenGreen.Views.DebtList.prototype, 'triggerDebtForm', this.renderDebtForm);
		this.listenTo(TheHiddenGreen.Views.DebtForm.prototype, 'submitDebtForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.InvestmentList.prototype, 'triggerInvestmentForm', this.renderInvestmentForm)
		this.listenTo(TheHiddenGreen.Views.InvestmentForm.prototype, 'submitInvestmentForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.IncomeList.prototype, 'triggerIncomeForm', this.renderIncomeForm)
		this.listenTo(TheHiddenGreen.Views.IncomeForm.prototype, 'submitIncomeForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.AccountList.prototype, 'triggerAccountForm', this.renderAccountForm)
		this.listenTo(TheHiddenGreen.Views.AccountForm.prototype, 'submitAccountForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.DebtList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.AccountList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.IncomeList.prototype, 'deleteItem', this.deleteItem)
	},

	render: function(){
		this.$el.html(JST['layouts/command_center']);
	},

	renderSubViews: function(){
		this.navigationButtons = new TheHiddenGreen.Views.NavigationButtons({
			el: '#navigationButtons'
		});

		activeView = new TheHiddenGreen.Views.ContentView({
			el: '#contentView'
		})
	},

	deleteItem: function(debtItem){
		debtItem.model.destroy({})
	},

	renderDebtForm: function(){
		this.removeCurrentWindow();
		activeView = new TheHiddenGreen.Views.DebtForm({
			el: '#contentView'
		});
	},

	renderInvestmentForm: function(){
		this.removeCurrentWindow();
		activeView = new TheHiddenGreen.Views.InvestmentForm({
			el: '#contentView'
		});
	},

	renderIncomeForm: function(){
		this.removeCurrentWindow();
		activeView = new TheHiddenGreen.Views.IncomeForm({
			el: '#contentView'
		});
	},

	renderAccountForm: function(){
		this.removeCurrentWindow();
		activeView = new TheHiddenGreen.Views.AccountForm({
			el: '#contentView'
		});
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
		activeView.unbind();
		activeView.$el.empty();
	},

	getDebts: function(){
		this.debtsCollection = new TheHiddenGreen.Collections.Debts();
		activeView = new TheHiddenGreen.Views.DebtList({
			el: '#contentView',
			collection: this.debtsCollection,
		});
		this.debtsCollection.fetch({data: { user_id: current_user.id} });
	},

	getSavings: function(){
		this.accountsCollection = new TheHiddenGreen.Collections.Accounts();
		activeView = new TheHiddenGreen.Views.AccountList({
			el: '#contentView',
			collection: this.accountsCollection,
		});
		this.accountsCollection.fetch({data: { user_id: current_user.id} });
	},

	getInvestments: function(){
		this.investmentCollection = new TheHiddenGreen.Collections.Investments();
		activeView = new TheHiddenGreen.Views.InvestmentList({
			el: '#contentView',
			collection: this.investmentCollection,
		});
		this.investmentCollection.fetch({data: { user_id: current_user.id} });
	},

	getIncome: function(){
		this.incomeCollection = new TheHiddenGreen.Collections.Incomes();
		activeView = new TheHiddenGreen.Views.IncomeList({
			el: '#contentView',
			collection: this.incomeCollection,
		});
		this.incomeCollection.fetch({data: { user_id: current_user.id} });
	},

	getSpending: function(){
		alert('you hit spending')
	}
})
