TheHiddenGreen.Views.Advices = Backbone.View.extend({

	initialize: function(){
		this.render();
	},

	render: function(){
		debugger;
		this.collection.each(this.renderAdvice, this)
	},

	renderAdvice: function(advice){
		this.advice = new TheHiddenGreen.Views.Advice({
			model: advice
		})
		this.$el.append(this.advice.el)
	}

})
