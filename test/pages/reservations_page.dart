

import 'package:webdriver/async_core.dart';

import '../automation.dart';
import '../models/reservations_items_list.dart';
import 'logged_in_page.dart';

class ReservationsPage extends LoggedInPage {
  static final String pageURL = 'https://*/admin/reservations';

  static ReservationsPage open() {
    Automation.driver.get(pageURL);
    var page = ReservationsPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath(
        "//div[contains(@class,'MuiBox-root ')]//h5[text()='Reservations']"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  List<ReservationItemsList> parseItems() {
    return Automation.driver.findElements(By.xpath("//div[contains(@class,'MuiPaper-elevation')]")).map((item) {
      scrollIntoView(item);
      var property = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-xs-10')]/p[1]")).text;
      var agent = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-2') and ./p[text()='Agent']]/p[2]")).text;
      var guest = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-xs-12') and ./a][1]")).text;
      var owner = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-xs-12') and ./a][2]")).text;
      var createdAt = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-xs-10')]/p[2]")).text;
      return ReservationItemsList(
            (b) => b
          ..property = property
          ..agent = agent
          ..owner = owner
          ..guest = guest
          ..createdAt = createdAt,
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
