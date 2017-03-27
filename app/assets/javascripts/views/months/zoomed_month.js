TheHiddenGreen.Views.ZoomedMonth = Backbone.View.extend({

	initialize: function(){
		this.render();
		this.renderAdvices();
		this.renderSideNav();
	},

	render: function(){
		this.$el.html(JST['layouts/individual_month']({month: this.model}))
	},

	renderAdvices: function(){
		this.adviceCollection = new TheHiddenGreen.Collections.Advices(this.model.get('advices'))
		this.advices = new TheHiddenGreen.Views.Advices({
			adviceArray: this.model.get('advices')
		})
		this.$el.find('.advices').append(this.advices.el);
	},

	renderSideNav: function(){
		this.sideNav = new TheHiddenGreen.Views.NavigationButtons({})
		this.$el.find('.sideNav').append(this.sideNav.el);
	}
})
