TheHiddenGreen.Views.Account = Backbone.View.extend({
  initialize: function(){
    this.render();
  },

  render: function(){
    this.$el.html(JST['accounts/account']({account: this.model}));
  }

});
