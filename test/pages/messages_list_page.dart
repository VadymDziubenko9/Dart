
import '../automation.dart';
import 'logged_in_page.dart';

class DashMessagesPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/messages';

  static DashMessagesPage open() {
    Automation.driver.get(pageURL);
    var page = DashMessagesPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    waitUntilVisibleByXpath("//h5[text()='Messages']");
    var maybeListShown = Automation.Try(() =>
        waitUntilVisibleByXpath(
            "//div[contains(@class,'MuiPaper-elevation')]//p[text()='Sender']",maxWait: Duration(seconds: 20)));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }
}