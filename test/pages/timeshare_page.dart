import 'package:webdriver/async_core.dart';

import '../automation.dart';

import '../models/timeshare.dart';
import 'logged_in_page.dart';

class TimesharePage extends LoggedInPage {
  static final String pageURL =
      'https://admin-qa.dashweek.com/admin/timeshares';

  static TimesharePage open() {
    Automation.driver.get(pageURL);
    var page = TimesharePage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath(
        "//div[contains(@class,'MuiBox-root')]/div[contains(@class,'MuiPaper-elevation')]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  List<Timeshare> parseItems() {
    return Automation.driver.findElements(By.xpath("//div[contains(@class,'MuiPaper-elevation')]")).map((item) {
      scrollIntoView(item);
      var owner = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-sm-6')]/a")).text;
      var property = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-2') and ./p][1]")).text;
            var priceXpath = "//div[contains(@class,'MuiGrid-grid-md-2') and ./p][2]";
      var netPrice = item.findElement(By.xpath(priceXpath)).text;
      var salePrice = item.findElement(By.xpath(priceXpath)).text;
      var reedWeekId = item.findElement(By.xpath(
              "//div[contains(@class,'MuiGrid-grid-md-2') and ./p][3]")).text;
      return Timeshare(
        (b) => b
          ..owner = owner
          ..property = property
          ..netPrice = netPrice
          ..salePrice = salePrice
          ..reedWeekId = reedWeekId,
      );
    }).toList();
  }

  @override
  bool filterBarMenuItemVisible(String item) {
    var result = isVisibleByXpath(
        "//div[contains(@class,'MuiGrid-grid-xl-3') and .//label[text()='$item']]");
    return result;
  }
  
}
