TheHiddenGreen.Views.Month = Backbone.View.extend({

	events:{
		'click .month' : "renderModal"
	},

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['months/month']({month: this.model.get("options") }))
	},

	renderModal: function(){
		var modelify = this.model.get('options').month
		this.monthModel = new TheHiddenGreen.Models.Month(modelify)
		this.trigger('clickedMonth', this.monthModel)
	}
})
