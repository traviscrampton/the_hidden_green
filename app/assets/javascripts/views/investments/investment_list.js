TheHiddenGreen.Views.InvestmentList = Backbone.View.extend({

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html('');
		this.collection.each(this.renderInvestment, this);
	},

	renderInvestment: function(investment){
		 this.$el.append(new TheHiddenGreen.Views.Investment({
			 model: investment
		 }).el);
	 },
})
