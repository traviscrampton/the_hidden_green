TheHiddenGreen.Views.Investment = Backbone.View.extend({
  initialize: function(){
    this.render();
  },

  render: function(){
    this.$el.html(JST['investments/investment']({investment: this.model}));
  }

});
