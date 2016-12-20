TheHiddenGreen.Views.Debt = Backbone.View.extend({
  initialize: function(){
    this.render();
  },

  render: function(){
		debugger;
    this.$el.html(JST['debts/debt']({debt: this.model}));
  }

});
