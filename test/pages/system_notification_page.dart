
import '../automation.dart';
import 'logged_in_page.dart';

class SystemNotificationsPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/system-notifications';

  static SystemNotificationsPage open() {
    Automation.driver.get(pageURL);
    var page = SystemNotificationsPage();
    page.waitTillPageLoaded();
    return page;
  }


  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath(
        "//div[contains(@class,'MuiTabs-flexContainer') and ./button[contains(@class,'MuiTab-textColorPrimary')] and .//text()='E-mails']"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }
}