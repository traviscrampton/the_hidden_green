$(function() {
  if ($("#dashboard").length) {
    return new TheHiddenGreen.Views.DashboardLayout({
      el:'#dashboard'
    });
  }
});
