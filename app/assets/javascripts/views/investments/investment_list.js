TheHiddenGreen.Views.InvestmentList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerInvestmentForm'
	},

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html(JST['investments/investment_list']);
		this.collection.each(this.renderInvestment, this);
	},

	renderInvestment: function(investment){
		 this.$el.append(new TheHiddenGreen.Views.Investment({
			 model: investment,
			 className: 'itemContainer'
		 }).el);
	 },
	 triggerInvestmentForm: function(){
		 this.trigger('triggerInvestmentForm')
	 }
})
