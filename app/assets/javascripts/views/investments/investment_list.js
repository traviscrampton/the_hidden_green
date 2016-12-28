TheHiddenGreen.Views.InvestmentList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerInvestmentForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Investment.prototype, 'deleteItem', this.clickedTrashCan)
	},

	render: function(){
		this.$el.html(JST['investments/investment_list']);
		this.collection.each(this.renderInvestment, this);
	},

	renderInvestment: function(investment){
		this.$el.append(new TheHiddenGreen.Views.Investment({
			model: investment,
			className:'itemContainer'
	}).el);
	},

	triggerInvestmentForm: function(){
		this.trigger('triggerInvestmentForm')
	},

	clickedTrashCan: function(investmentItem){
		this.trigger('deleteItem', investmentItem)
	}


})
