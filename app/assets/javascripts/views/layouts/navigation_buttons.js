TheHiddenGreen.Views.NavigationButtons = Backbone.View.extend({

	events: {
		'click .navigation__button' : 'selectFinancial'
	},

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['layouts/navigation_buttons']);
	},

	selectFinancial: function(e){
		var data = $(e.currentTarget).attr("data")
		this.trigger('selectFinancial', data);
		this.highlightSelectedButton(e);
	},

	highlightSelectedButton: function(e){
		$('.navigation__button').removeClass('selected__navigation__button');
		$(e.currentTarget).addClass('selected__navigation__button');
	}
})
