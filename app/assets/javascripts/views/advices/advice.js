TheHiddenGreen.Views.Advice = Backbone.View.extend({

	initialize: function(options){
		this.render()
	},

	render: function(){
		this.$el.html(JST['advices/advice']({advice: this.model}))
	}
})
