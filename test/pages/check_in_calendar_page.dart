
import '../automation.dart';
import 'logged_in_page.dart';

class CheckInCalendarPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/calendar';

  static CheckInCalendarPage open() {
    Automation.driver.get(pageURL);
    var page = CheckInCalendarPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    waitUntilVisibleByXpath("//div[contains(@class,'MuiBox-root') and ./p[text()='Check-in calendar']]");
    var maybeListShown = Automation.Try(() =>
        waitUntilVisibleByXpath(
            "//div[contains(@class,'css-1vww2ec')]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }
}