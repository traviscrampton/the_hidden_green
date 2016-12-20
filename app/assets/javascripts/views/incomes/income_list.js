TheHiddenGreen.Views.IncomeList = Backbone.View.extend({

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html('');
		this.collection.each(this.renderIncome, this);
	},

	renderIncome: function(income){
		 this.$el.append(new TheHiddenGreen.Views.Income({
			 model: income
		 }).el);
	 },
})
