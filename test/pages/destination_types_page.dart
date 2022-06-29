import '../automation.dart';
import 'logged_in_page.dart';

class DestinationTypesPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/destination-types';

  static DestinationTypesPage open() {
    Automation.driver.get(pageURL);
    var page = DestinationTypesPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    waitUntilVisibleByXpath("//div[contains(@class, 'MuiBox-root') and ./p[text()='Destination types']]");
    var maybeListShown = Automation.Try(() =>
        waitUntilVisibleByXpath(
            "//div[contains(@class, 'MuiBox-root')]//div[contains(@class,'MuiPaper-elevation')]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }
}