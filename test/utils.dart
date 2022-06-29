import 'package:intl/intl.dart';

import 'automation.dart';
import 'models/dash_portal_user.dart';
import 'pages/dash_list_page.dart';
import 'pages/logged_in_page.dart';
import 'pages/logged_in_page.dart' as dash_logged_in_page;
import 'pages/login_page.dart' as dash_login_page;
import 'pages/login_page.dart';
import 'pages/opened_dash_page.dart';


DateFormat standardDateFormat = DateFormat('MM/dd/yyyy');
DateFormat dateInputValueGetFormat = DateFormat('yyyy-MM-dd');
DateFormat timeInputSetFormat = DateFormat('hhmma');
DateFormat timeInputGetFormat = DateFormat('hh:mm a');
DateFormat clientPortalBatchCreatedOnDateFormat = DateFormat('dd - dd, yyyy');
DateFormat invoiceDueDateFormat = DateFormat('dd, yyyy');
DateFormat batchCreatedOnDateFormat = DateFormat('MMMM dd, yyyy h:mm a');
DateFormat invoicePaidAtDateFormat = DateFormat('MMMM dd, yyyy h:mm a');
DateFormat batchCreatedOnBackEndDateFormat = DateFormat(
    'MMMM dd, yyyy hh:mm a'); //ToDo remove after https://github.com/entanglemediallc/shimlaw/issues/1434


OpenCasesPage loginAdminToCasePortalIfNotLoggedIn() {
  Automation.driver.get(LoginPage.pageURL);
  if (LoggedInPage.loggedIn()) {
    LoggedInPage().logOut();
  }
  return LoginPage().open().loginUser(DashPortalUser.vadymDashweekAdmin) as OpenCasesPage;
}


OpenCasesPage loginStaffToCasePortalIfNotLoggedIn() {
  Automation.driver.get(LoginPage.pageURL);
  if (LoggedInPage.loggedIn()) {
    LoggedInPage().logOut();
  }
  return LoginPage().open().loginUser(DashPortalUser.vadymDashweekAdmin) as OpenCasesPage;
}

DashListPage loginClientToClientPortalIfNotLoggedIn() {
  Automation.driver.get(dash_login_page.LoginPage.pageURL);
  if (dash_logged_in_page.LoggedInPage.loggedIn()) {
    dash_logged_in_page.LoggedInPage().logOut();
  }
  return dash_login_page.LoginPage().open().loginUser(DashPortalUser.vadymDashweekAdmin);
}