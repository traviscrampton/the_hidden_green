TheHiddenGreen.Views.Advices = Backbone.View.extend({

	initialize: function(options){
		this.adviceArray = options.adviceArray
		this.render();
	},

	render: function(){
		_.each(this.adviceArray, this.renderAdvice, this);
	},

	renderAdvice: function(advice){
		this.advice = new TheHiddenGreen.Views.Advice({
			advice: advice
		})
		this.$el.append(this.advice.el)
	}

})
