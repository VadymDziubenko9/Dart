
import 'package:webdriver/async_core.dart';

import '../automation.dart';
import '../models/reservation_request_items_list.dart';
import 'logged_in_page.dart';

class ReservationRequestsPage extends LoggedInPage {
  static final String pageURL = 'https:/*/reservation/requests';

  static ReservationRequestsPage open() {
    Automation.driver.get(pageURL);
    var page = ReservationRequestsPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath(
        "//div[@id='content']//p[text()='Reservation Requests']"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  List<ResrvationsRequestItemsList> parseItems() {
    return Automation.driver.findElements(By.xpath("//div[contains(@class,'MuiPaper-elevation')]")).map((item) {
      scrollIntoView(item);
      var property = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-3') and ./p]")).text;
      var guest = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-2')]/a")).text;
      var agents = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-3') and ./p[text()='Agent']]/p[2]")).text;
      return ResrvationsRequestItemsList(
            (b) => b
          ..property = property
          ..guest = guest
          ..agents = agents,
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
