TheHiddenGreen.Views.ZoomedMonth = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		debugger;
		this.$el.html(JST['layouts/individual_month'])
	}
})
