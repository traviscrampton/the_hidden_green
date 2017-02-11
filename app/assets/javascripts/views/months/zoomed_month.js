TheHiddenGreen.Views.ZoomedMonth = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['layouts/individual_month']({month: this.model}))
	}
})
