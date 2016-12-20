TheHiddenGreen.Views.DebtList = Backbone.View.extend({

	initialize: function(){
		this.listenTo(this.collection, 'sync', this.render);
	},

	render: function(){
		this.$el.html('');
		this.collection.each(this.renderDebt, this);
	},

	renderDebt: function(debt){
		 this.$el.append(new TheHiddenGreen.Views.Debt({
			 model: debt
		 }).el);
	 },
})
