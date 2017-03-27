TheHiddenGreen.Views.Advice = Backbone.View.extend({

	initialize: function(options){
		this.advice = options.advice
		this.render()
	},

	render: function(){
		this.$el.html(JST['advices/advice']({advice: this.advice}))
	}
})
