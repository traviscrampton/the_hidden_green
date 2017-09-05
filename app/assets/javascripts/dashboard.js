$(function() {
  if ($("#dashboardz").length) {
    return new TheHiddenGreen.Views.DashboardLayout({
      el:'#dashboardz'
    });
  } else if($('#calendars').length) {
		return new TheHiddenGreen.Views.Calendar({
			el:'#calendars'
		})
	}
});
