import 'dart:io';

import 'package:webdriver/async_core.dart';

import '../automation.dart';
import '../models/dash_portal_user_list_item.dart';
import 'logged_in_page.dart';

class OwnersPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/owners';

  static OwnersPage open() {
    Automation.driver.get(pageURL);
    var page = OwnersPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath("//div[@id='content']//p[text()='Owners']"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  void searchUser(String user){
    scrollToTop();
    MuiInput("//div[contains(@class, 'MuiFormControl-root') and .//label[text()='Search']]").value = user;
    sleep(Duration(milliseconds: 2000));
  }

  List<DashPortalUserListItem> parseUsers() {
    var items = Automation.driver.findElements(By.xpath(
        "//div[contains(@class,'MuiBox-root')]/div[contains(@class,'MuiPaper-elevation')]"));
    var result = items.map((item) {
      scrollIntoView(item);
      var name = item.findElement(By.xpath(".//div[contains(@class,'MuiGrid-grid-md-3')][1]//p[2]")).text;
      var email = item.findElement(By.xpath(".//div[contains(@class,'MuiGrid-grid-md-3')][3]//p[1]")).text;
      var emailNotificationsEnabled = findOptionalChild(
          item, By.xpath(
          ".//div[@aria-label='Email notifications enabled']")) ==
          null
          ? false
          : true;
      var smsNotificationsEnabled = findOptionalChild(
          item, By.xpath(
          ".//div[@aria-label='SMS notifications enabled']")) ==
          null
          ? false
          : true;

      return DashPortalUserListItem(
              (b) => b
            ..email = email
            ..name = name
            ..smsNotification = smsNotificationsEnabled
            ..emailNotification = emailNotificationsEnabled

      );
    }).toList();
    scrollToTop();
    return result;
  }

}