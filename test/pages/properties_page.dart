import 'package:webdriver/async_core.dart';

import '../automation.dart';
import '../models/properties_items_list.dart';
import 'logged_in_page.dart';

class PropertiesPage extends LoggedInPage {
  static final String pageURL = 'https://*/properties';

  static PropertiesPage open() {
    Automation.driver.get(pageURL);
    var page = PropertiesPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    waitUntilVisibleByXpath("//div[contains(@class, 'MuiBox-root') and ./p[text()='Properties']]");
    var maybeListShown = Automation.Try(() =>
        waitUntilVisibleByXpath(
            "//div[contains(@class, 'MuiBox-root')]//div[contains(@class,'MuiPaper-elevation')]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  List<PropertyItemsList> parseItems() {
    return Automation.driver.findElements(By.xpath("//div[contains(@class,'MuiPaper-elevation')]")).map((item) {
      scrollIntoView(item);
      var property = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-3') and ./p]")).text;
      var destination = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-1')][1]/p[2]")).text;
      var country = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-1')][2]/p[2]")).text;
      var region = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-2')]/p[2]")).text;
      var agents = item.findElement(By.xpath("//div[contains(@class,'MuiGrid-grid-md-4')]/p[2]")).text;
      return PropertyItemsList(
            (b) => b
          ..property = property
          ..destination = destination
          ..country = country
          ..region = region
          ..agents = agents,
      );
    }).toList();
  }

}
