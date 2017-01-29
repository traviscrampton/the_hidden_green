$(function() {
  if ($("#dashboard").length) {
    return new TheHiddenGreen.Views.DashboardLayout({
      el:'#dashboard'
    });
  } else if($('#calendars').length) {
		return new TheHiddenGreen.Views.Calendar({
			el:'#calendars'
		})
	}
});
