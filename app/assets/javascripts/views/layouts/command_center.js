TheHiddenGreen.Views.CommandCenter = Backbone.View.extend({

	initialize: function(){
		this.render();
		this.renderSubViews();
		this.setupEvents();
	},

	setupEvents: function(){
		this.listenTo(this.navigationButtons, 'selectFinancial', this.selectFinancial);
		this.listenTo(TheHiddenGreen.Views.DebtList.prototype, 'triggerDebtForm', this.renderDebtForm);
		this.listenTo(TheHiddenGreen.Views.DebtForm.prototype, 'submitDebtForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.InvestmentList.prototype, 'triggerInvestmentForm', this.renderInvestmentForm)
		this.listenTo(TheHiddenGreen.Views.InvestmentList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.InvestmentForm.prototype, 'submitInvestmentForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.IncomeList.prototype, 'triggerIncomeForm', this.renderIncomeForm)
		this.listenTo(TheHiddenGreen.Views.IncomeForm.prototype, 'submitIncomeForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.AccountList.prototype, 'triggerAccountForm', this.renderAccountForm)
		this.listenTo(TheHiddenGreen.Views.AccountForm.prototype, 'submitAccountForm', this.selectFinancial)
		this.listenTo(TheHiddenGreen.Views.DebtList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.DebtList.prototype, 'editItem', this.renderDebtForm)
		this.listenTo(TheHiddenGreen.Views.AccountList.prototype, 'editItem', this.renderAccountForm)
		this.listenTo(TheHiddenGreen.Views.IncomeList.prototype, 'editItem', this.renderIncomeForm)
		this.listenTo(TheHiddenGreen.Views.InvestmentList.prototype, 'editItem', this.renderInvestmentForm)
		this.listenTo(TheHiddenGreen.Views.AccountList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.IncomeList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.MonthlySpendingList.prototype, 'deleteItem', this.deleteItem)
		this.listenTo(TheHiddenGreen.Views.MonthlySpendingList.prototype, 'editItem', this.renderMonthlySpendingForm)
		this.listenTo(TheHiddenGreen.Views.MonthlySpendingList.prototype, 'triggerMonthlySpendingForm', this.renderMonthlySpendingForm);
		this.listenTo(TheHiddenGreen.Views.MonthlySpendingForm.prototype, 'submitMonthlySpendingForm', this.selectFinancial)
	},

	render: function(){
		this.$el.html(JST['layouts/command_center']);
	},

	renderSubViews: function(){
		this.navigationButtons = new TheHiddenGreen.Views.NavigationButtons({
			el: '#navigationButtons'
		});

		this.activeView = new TheHiddenGreen.Views.ContentView({});
		this.$el.find('#contentView').append(this.activeView.$el);
	},

	deleteItem: function(debtItem){
		debtItem.model.destroy({})
	},

	renderDebtForm: function(model){
		this.removeCurrentWindow();
		this.activeView = new TheHiddenGreen.Views.DebtForm({
			model: model
		});
		this.renderFinancial();
	},

	renderMonthlySpendingForm: function(model){
		this.removeCurrentWindow()
		this.activeView = new TheHiddenGreen.Views.MonthlySpendingForm({
			model: model
		})
		this.renderFinancial();
	},

	renderInvestmentForm: function(model){
		this.removeCurrentWindow();
		this.activeView = new TheHiddenGreen.Views.InvestmentForm({
			model: model
		});
		this.renderFinancial();
	},

	renderIncomeForm: function(model){
		this.removeCurrentWindow();
		this.activeView = new TheHiddenGreen.Views.IncomeForm({
			model: model
		});
		this.renderFinancial();
	},

	renderAccountForm: function(model){
		this.removeCurrentWindow();
		this.activeView = new TheHiddenGreen.Views.AccountForm({
			model: model
		});
		this.renderFinancial();
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
		viewHash[data].call(this);
		this.renderFinancial();
	},

	renderFinancial: function(){
		this.$el.find('#contentView').append(this.activeView.$el);
	},

	removeCurrentWindow: function(){
		this.activeView.remove();
	},

	getDebts: function(){
		this.debtsCollection = new TheHiddenGreen.Collections.Debts();
		this.activeView = new TheHiddenGreen.Views.DebtList({
			collection: this.debtsCollection,
		});
		this.debtsCollection.fetch({});
	},

	getSavings: function(){
		this.accountsCollection = new TheHiddenGreen.Collections.Accounts();
		this.activeView = new TheHiddenGreen.Views.AccountList({
			collection: this.accountsCollection
		});
		this.accountsCollection.fetch({});
	},

	getInvestments: function(){
		this.investmentCollection = new TheHiddenGreen.Collections.Investments();
		this.activeView = new TheHiddenGreen.Views.InvestmentList({
			collection: this.investmentCollection
		});
		this.investmentCollection.fetch({});
	},

	getIncome: function(){
		this.incomeCollection = new TheHiddenGreen.Collections.Incomes();
		this.activeView = new TheHiddenGreen.Views.IncomeList({
			collection: this.incomeCollection
		});
		this.incomeCollection.fetch({});
	},

	getSpending: function(){
		this.spendingCollection = new TheHiddenGreen.Collections.MonthlySpendings();
		this.activeView = new TheHiddenGreen.Views.MonthlySpendingList({
			collection: this.spendingCollection
		});
		this.spendingCollection.fetch({})
	}
})
