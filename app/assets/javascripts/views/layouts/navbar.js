TheHiddenGreen.Views.Navbar = Backbone.View.extend({

	events:{
		'click .getSetup' : 'calculateYearView'
	},

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(JST['layouts/navbar']);
	},

	calculateYearView: function(){
		var self = this;
		$.ajax({
			url:'/yearview',
			type: 'GET',
			success: function(data){
				self.replaceText();
			},
			error: function(data){
				console.log(data)
			}
		})
	},

	replaceText: function(){
		debugger;
		this.$el.find('.getSetup').replaceWith("<span><a href='/calendars'>View Calendar</a></span>")
	}
})
