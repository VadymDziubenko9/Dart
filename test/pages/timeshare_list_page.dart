
import 'package:webdriver/async_core.dart';

import '../automation.dart';
import '../models/timeshare.dart';
import 'logged_in_page.dart';

class DashListPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/timeshares';

  static DashListPage open() {
    Automation.driver.get(pageURL);
    var page = DashListPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() =>
        waitUntilVisibleByXpath(
            "//div[contains(@class,'MuiBox-root')]/div[contains(@class,'MuiPaper-elevation')]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  String timeshareItemXpath(String item) {
    return "//ul[contains(@class, 'MuiList-root')]/li[a/div/p[1][text()='$item']]";
  }

  // dynamic openTimeshare(Timeshare caze, {bool detailsSet = false}) {
  //   var caseItem = Automation.driver.findElement(By.xpath(timeshareItemXpath(caze.reedWeekId!)));
  //   scrollIntoView(caseItem);
  //   scrollVerticallyBy(-50);
  //   caseItem.click();
  //   var result = detailsSet ? CaseBatchesPage() : CaseDetailsPage();
  //   result.waitTillPageLoaded();
  //   return result;
  // }

}