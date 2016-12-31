TheHiddenGreen.Views.InvestmentList = Backbone.View.extend({

	events:{
		'click .triggerForm' : 'triggerInvestmentForm'
	},

	initialize: function(){
		this.listenToOnce(this.collection, 'sync', this.render);
		this.listenTo(TheHiddenGreen.Views.Investment.prototype, 'deleteItem', this.clickedTrashCan)
		this.listenTo(TheHiddenGreen.Views.Investment.prototype, 'editItem', this.clickedPencil)
	},

	render: function(){
		this.$el.append(JST['investments/investment_list']);
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

	clickedTrashCan: function(model){
		this.trigger('deleteItem', model)
	},

	clickedPencil: function(model){
		this.trigger('editItem', model)
	}


})
