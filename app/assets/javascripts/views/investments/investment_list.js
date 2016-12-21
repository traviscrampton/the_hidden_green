TheHiddenGreen.Views.InvestmentList = Backbone.View.extend({

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html(JST['investments/investment_list']);
		this.collection.each(this.renderInvestment, this);
	},

	renderInvestment: function(investment){
		 this.$el.prepend(new TheHiddenGreen.Views.Investment({
			 model: investment,
			 className: 'itemContainer'
		 }).el);
	 },
})
