import 'dart:io';

import 'package:webdriver/async_core.dart';

import '../automation.dart';
import 'logged_in_page.dart';

class HelpDescPage extends LoggedInPage {
  static final String pageURL = 'https://*/helpdesk';

  static HelpDescPage open() {
    Automation.driver.get(pageURL);
    var page = HelpDescPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath("//div[contains(@class,'MuiBox-root') and ./p[text()='Helpdesk']]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  void select() {
    var users = Automation.driver.findElement(By.xpath("//div[contains(@class,'MuiBox-root')]/li"));
      clickOnXpath("${users.locator.value}//span[text()='Kyrylo Zinovyev']");
  }
  
  bool isUserCharAppear() => isVisibleByXpath("//div[contains(@class,'MuiBox-root') and ./p[text()='Kyrylo Zinovyev']]");

  void openMessageDialog() {
    select();
    isUserCharAppear();
    sleep(Duration(seconds: 1));
  }
}
