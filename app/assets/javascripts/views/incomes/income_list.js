TheHiddenGreen.Views.IncomeList = Backbone.View.extend({

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html(JST['incomes/income_list']);
		this.collection.each(this.renderIncome, this);
	},

	renderIncome: function(income){
		 this.$el.prepend(new TheHiddenGreen.Views.Income({
			 model: income,
			 className:'itemContainer'
		 }).el);
	 },
})
