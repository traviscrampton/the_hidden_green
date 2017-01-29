TheHiddenGreen.Views.Month = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['months/month']({calendar: this.model }))
		this.renderDebts();
		this.renderAccounts();
		this.renderInvestments();
	},

	renderDebts: function(){
		this.debtCollection = new TheHiddenGreen.Collections.Debts(this.model.get('debts'))
		this.debts = new TheHiddenGreen.Views.CalendarDebtList({
			collection: this.debtCollection
		})
		this.$el.find('.debt_list').append(this.debts.el)
	},

	renderAccounts: function(){
		this.accountCollection = new TheHiddenGreen.Collections.Accounts(this.model.get('accounts'))
		this.accounts = new TheHiddenGreen.Views.CalendarAccountList({
			collection: this.accountCollection
		})
		this.$el.find('.saving_list').append(this.accounts.el)
	},

	renderInvestments: function(){
		this.investmentCollection = new TheHiddenGreen.Collections.Investments(this.model.get('investments'))
		this.investments = new TheHiddenGreen.Views.CalendarInvestmentList({
			collection: this.investmentCollection
		})
		this.$el.find('.investment_list').append(this.investments.el)
	}
})
