import 'package:test/test.dart' hide test;

import 'package:test/scaffolding.dart';
import 'models/dash_portal_user.dart';
import 'models/payroll_list.dart';
import 'pages/check_in_calendar_page.dart';
import 'pages/dash_list_page.dart';
import 'pages/destination_types_page.dart';
import 'pages/expenses_page.dart';
import 'pages/guests_page.dart';
import 'pages/helpDesk_page.dart';
import 'pages/login_page.dart' as dash_login_page;
import 'automation.dart';
import 'pages/owners_page.dart';
import 'pages/payroll_page.dart';
import 'pages/profile_page.dart' as dash_profile_page;
import 'pages/properties_page.dart';
import 'pages/reservation_requests_page.dart';
import 'pages/reservations_page.dart';
import 'pages/system_notification_page.dart';
import 'pages/timeshare_page.dart';
import 'test_sugar.dart';
import 'pages/messages_list_page.dart';

void main() async {
  await Automation.initDriver();

  test(
    'User should be able to open DashWeek login page',
        () {
      expect(dash_login_page.LoginPage().open, returnsNormally);
    },
  );

  test(
    'Admin should be able to log in to the DashWeek',
        () {
      given('a registered user');
      var admin = DashPortalUser.vadymDashweekAgent;

      when('he opens the Dashweek log in page');
      var loginPage = dash_login_page.LoginPage().open();

      then('he should be able to log in there');
      and('the admin user should be navigated to the Agent page');
      var dashListPage = loginPage.loginUser(admin);

      and('the company`s name should be shown in the page header');
      expect(dashListPage.loggedInUserName, contains(admin.lastName));

      and('admin should be included into the Agent list of users');
      expect(dashListPage.parseUsers(), contains(DashPortalUser.vadymDashweekAgent.toListAdmins()));
    },
  );

  test(
    'Correct user context menu items should be shown for dash admin',
        () {
      given('an admin logged in on the DashWeek');
      var dashListView = DashListPage();

      when('he expands the user context menu');
      then('correct items should be shown there');
      expect(dashListView.userContextMenuItemVisible('Profile'), isTrue);
      expect(dashListView.userContextMenuItemVisible('Logout'), isTrue);
    },
  );

  test(
    'Admin should be able to open his My Profile view',
        () {
      given('client is on the case batches page');
      var dashListView = DashListPage();

      when('he selects the `Profile` item in the profile context menu');
      then('the `Profile` view should open');
      dashListView.selectUserContextMenuItem('Profile');
      var profileView = dash_profile_page.ProfilePage();

      and('correct profile info should be shown there');
      profileView.verifyProfile(DashPortalUser.vadymDashweekAdmin);
    },
  );

  test(
    'Admin should be able to open the `Messages` view',
        () {
      given('admin is on the `Messages` view');
      var messageView = DashMessagesPage();

      when('he selects the `Messages` item in the side panel menu');
      messageView.selectMainMenuItem('Messages');

      then('the Messages view should open');
      expect(messageView.waitTillPageLoaded, returnsNormally);
    },
  );

  test(
    'Admin should be able to open the `Check-in Calendar` view',
        () {
      given('admin is on the `Check-in Calendar` view');
      var calendarView = CheckInCalendarPage();

      when('he selects the `Check-in calendar` item in the side panel menu');
      calendarView.selectMainMenuItem('Check-in Calendar');

      then('the `Check-in Calendar` view should open');
      expect(calendarView.waitTillPageLoaded, returnsNormally);
    },
  );

  test(
    'Admin should be able to open the `System Notifications` view',
        () {
      given('admin is on the `System Notifications` view');
      var systemNotificationsView = SystemNotificationsPage();

      when('he selects the `System Notification` item in the side panel menu');
      systemNotificationsView.selectMainMenuItem('System Notifications');

      then('the `System Notifications` view should open');
      expect(systemNotificationsView.waitTillPageLoaded, returnsNormally);
    },
  );

  test(
    'Admin should be able to open the `Payroll` view',
        () {
      given('admin is on the `Payroll` view');
      var payrollView = PayrollPage();

      when('he selects the `System Notification` item in the side panel menu');
      payrollView.selectMainMenuItem('Payroll');

      then('the `Payroll` view should open');
      expect(payrollView.waitTillPageLoaded, returnsNormally);

      when('admin select a date from 1/1/2022 to day today');
      var now = DateTime.now();
      var expectedInvoice = Payroll(
            (b) => b
          ..startDate = DateTime(2022, 1, 1)
          ..endDate = DateTime(now.year, now.month , now.day),
      );
      payrollView.addPayrollData(expectedInvoice);
      and('invoices should be listed there');
      expect(payrollView.parseItems(), isNotEmpty);
    },
  );

  test(
    'Admin should be able to open the `Expenses` view',
        () {
      given('admin is on the `Expenses` view');
      var expensesView = ExpensesPage();

      when('he selects the `Expenses` item in the side panel menu');
      expensesView.selectMainMenuItem('Expenses');

      then('the `Expenses` view should open');
      expect(expensesView.waitTillPageLoaded, returnsNormally);
    },
  );

  test(
    'Admin should be able to open the `Helpdesk` view',
        () {
      given('admin is on the `Helpdesk` view');
      var helpDeskView = HelpDescPage();

      when('he selects the `Helpdesk` item in the side panel menu');
      helpDeskView.selectMainMenuItem('Helpdesk');

      then('the `Helpdesk` view should open');
      expect(helpDeskView.waitTillPageLoaded, returnsNormally);

      and('admin should be able to open chat with user client');
      helpDeskView.openMessageDialog();
    },
  );

  test(
    'Admin should be able to open the `Owners` view',
        () {
      given('admin is on the `Owners` view');
      var ownersView = OwnersPage();

      when('he selects the `Owners` item in the side panel menu');
      ownersView.selectMainMenuItem('Owners');

      then('the `Owners` view should open');
      expect(ownersView.waitTillPageLoaded, returnsNormally);

      and('owner`s should be included and found by his first name');
      ownersView.searchUser(DashPortalUser.vadymDashweekOwner.firstName);
      expect(ownersView.parseUsers(), contains(DashPortalUser.vadymDashweekOwner.toListOwners()));
    },
  );

  test(
    'Admin should be able to open the `Destination types` view',
        () {
      given('admin is on the `Destination types` view');
      var destinationTypesView = DestinationTypesPage();

      when('he selects the `Destination types` item in the side panel menu');
      destinationTypesView.selectMainMenuItem('Destination Types');

      then('the `Destination types` view should open');
      expect(destinationTypesView.waitTillPageLoaded, returnsNormally);
    },
  );

  test(
    'Admin should be able to open the `Properties` view',
        () {
      given('admin is on the `Properties` view');
      var propertiesView = PropertiesPage();

      when('he selects the `Properties` item in the side panel menu');
      propertiesView.selectMainMenuItem('Properties');

      then('the `Properties` view should open');
      expect(propertiesView.waitTillPageLoaded, returnsNormally);

      and('Properties should be listed there');
      expect(propertiesView.parseItems(), isNotEmpty);
    },
  );

  test(
    'Admin should be able to open the `Timeshares` view',
        () {
      given('admin is on the `Timeshares` view');
      var timeshareView = TimesharePage();

      when('he selects the `Timeshares` item in the side panel menu');
      timeshareView.selectMainMenuItem('Timeshares');

      then('the `Timeshares` view should open');
      expect(timeshareView.waitTillPageLoaded, returnsNormally);

      and('Timeshares should be listed there');
      expect(timeshareView.parseItems(), isNotEmpty);

      and('Timeshares filter bar should be displaying there');
      expect(timeshareView.filterBarMenuItemVisible('Verified'), isTrue);
      expect(timeshareView.filterBarMenuItemVisible('Statuses'), isTrue);
      expect(timeshareView.filterBarMenuItemVisible('Start date'), isTrue);
      expect(timeshareView.filterBarMenuItemVisible('End date'), isTrue);
      expect(timeshareView.filterBarMenuItemVisible('Property'), isTrue);
      expect(timeshareView.filterBarMenuItemVisible('Region'), isTrue);
      expect(timeshareView.filterBarMenuItemVisible('Country'), isTrue);
    },
  );

  test(
    'Admin should be able to open the `Guests` view',
    () {
      given('admin is on the `Guests` view');
      var guestsView = GuestsPage();

      when('he selects the `Guests` item in the side panel menu');
      guestsView.selectMainMenuItem('Guests');

      then('the `Guests` view should open');
      expect(guestsView.waitTillPageLoaded, returnsNormally);

      and('guest should be included and found by his last name');
      guestsView.searchUser(DashPortalUser.vadymDashweekGuest.lastName);
      expect(guestsView.parseUsers(), contains(DashPortalUser.vadymDashweekGuest.toListGuests()));
    },
  );

  test(
    'Admin should be able to open the `Reservation Requests` view',
    () {
      given('admin is on the `Reservation Requests` view');
      var reservationRequestView = ReservationRequestsPage();

      when('he selects the `Reservation Requests` item in the side panel menu');
      reservationRequestView.selectMainMenuItem('Reservation Requests');

      then('the `Reservation Requests` view should open');
      expect(reservationRequestView.waitTillPageLoaded, returnsNormally);

      and('Reservation Requests should be listed there');
      expect(reservationRequestView.parseItems(), isNotEmpty);

      and('Reservation Requests filter bar should be displaying there');
      expect(reservationRequestView.filterBarMenuItemVisible('Guest'), isTrue);
      expect(reservationRequestView.filterBarMenuItemVisible('Agent'), isTrue);
      expect(reservationRequestView.filterBarMenuItemVisible('Statuses'), isTrue);
    },
  );

  test(
    'Admin should be able to open the `Reservations` view',
    () {
      given('admin is on the `Reservations` view');
      var reservationsView = ReservationsPage();

      when('he selects the `Reservations` item in the side panel menu');
      reservationsView.selectMainMenuItem('Reservations');

      then('the `Reservations` view should open');
      expect(reservationsView.waitTillPageLoaded, returnsNormally);

      and('Reservations should be listed there');
      expect(reservationsView.parseItems(), isNotEmpty);

      and('Reservations filter bar should be displaying there');
      expect(reservationsView.filterBarMenuItemVisible('Statuses'), isTrue);
      expect(reservationsView.filterBarMenuItemVisible('Start date'), isTrue);
      expect(reservationsView.filterBarMenuItemVisible('End date'), isTrue);
      expect(reservationsView.filterBarMenuItemVisible('Agent'), isTrue);
      expect(reservationsView.filterBarMenuItemVisible('Guest'), isTrue);
      expect(reservationsView.filterBarMenuItemVisible('Owner'), isTrue);
      expect(reservationsView.filterBarMenuItemVisible('Property'), isTrue);
    },
  );

  tearDownAll(() {
    Automation.driver.quit();
    Automation.terminateChrome();
  });
}
