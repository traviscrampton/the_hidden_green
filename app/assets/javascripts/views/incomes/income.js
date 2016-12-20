TheHiddenGreen.Views.Income = Backbone.View.extend({
  initialize: function(){
    this.render();
  },

  render: function(){
    this.$el.html(JST['incomes/income']({income: this.model}));
  }

});
