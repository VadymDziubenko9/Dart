import 'dart:io';

import 'package:webdriver/sync_io.dart';

import '../automation.dart';
import '../models/dash_portal_user_list_item.dart';
import 'logged_in_page.dart';

class DashListPage extends LoggedInPage{
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/agents';

  static DashListPage open() {
    Automation.driver.get(pageURL);
    var page = DashListPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath("//div[contains(@class,'MuiBox-root')]/div[contains(@class,'MuiPaper-elevation')]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  String timeshareItemXpath(String caseName) {
    return "//div[contains(@class,'MuiPaper-elevation')]//div[contains(@class,'MuiGrid-grid-md-2')][1]/p";
  }


  void expandTimeshare(String caseTitle) {
    clickOnXpath("${timeshareItemXpath(caseTitle)}//div[@class='MuiListItemSecondaryAction-root']/button");
    waitUntilVisibleByXpath("//ul/a[contains(text(), 'Case details')]");
  }

  void selectCaseDetailsContextMenuItem() {
    clickOnXpath("//ul/a[contains(text(), 'Case details')]");
    waitUntilVisibleByXpath("//form/h6[text()='Claimant']");
  }

  void openSetDetailsView(String caseTitle) {
    expandTimeshare(caseTitle);
    selectCaseDetailsContextMenuItem();
    sleep(Duration(seconds: 1));
  }

  void openCasesTab(String tabName) {
    clickOnXpath("//div[contains(@class, 'MuiTabs')]/button[span[text()='$tabName']]");
    var maybeCircularIndicator = Automation.Try(() => waitUntilVisibleByXpath(
        "//div[contains(@class, 'MuiCircularProgress-root')]",
        pollingInterval: Duration(milliseconds: 5)));
    if (maybeCircularIndicator is Success) {
      waitUntilNotVisibleByXpath("//div[contains(@class, 'MuiCircularProgress-root')]");
    }
    waitUntilVisibleByXpath(
        "//div[contains(@class, 'MuiTabs')]/button[contains(@class, 'Mui-selected') and span[text()='$tabName']]");
  }

  void openArchivedCases() => openCasesTab('archived');

  void openOpenCases() => openCasesTab('open');

  void openPendingCases() => openCasesTab('pending');

  void openRejectedCases() => openCasesTab('rejected');

  void openNeedsUploadCases() => openCasesTab('Needs upload');

  static final String _createCaseModalXpath =
      "//div[contains(@class, 'MuiDialog-paper') and .//h2[text()='Create case']]";

  void openCreateCaseModal() {
    clickOnXpath("//button[contains(@class, 'MuiFab-root')]");
    waitUntilVisibleByXpath(_createCaseModalXpath);
  }

  String activeCasesTab() {
    var result = Automation.driver
        .findElement(By.xpath("//div[contains(@class, 'MuiTabs-root')][1]//button[contains(@class, 'Mui-selected')]"))
        .text
        .toLowerCase()
        .trim();
    return result == 'needs upload' ? 'needsUpload' : result;
  }

  List<DashPortalUserListItem> parseUsers() {
    var items = Automation.driver.findElements(By.xpath(
        "//div[contains(@class,'MuiBox-root')]/div[contains(@class,'MuiPaper-elevation')]"));
    var result = items.map((item) {
      scrollIntoView(item);
      var role = item.findElement(By.xpath(".//div[contains(@class,'MuiGrid-grid-md-3')][1]//p[1]")).text;
      var name = item.findElement(By.xpath(".//div[contains(@class,'MuiGrid-grid-md-3')][1]//p[2]")).text;
      var phoneNumber = item.findElement(By.xpath(".//div[contains(@class,'MuiGrid-grid-md-3')][2]//p[1]"))
          .text
          .replaceFirst('+', '')
          .replaceFirst('(', '')
          .replaceFirst(')', '')
          .replaceFirst('-', '')
          .replaceFirst(' ', '')
          .replaceFirst(' ', '')
          .trim();
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
              ..phoneNumber = phoneNumber
              ..role = role
              ..smsNotification = smsNotificationsEnabled
              ..emailNotification = emailNotificationsEnabled

      );
    }).toList();
    scrollToTop();
    return result;
  }
  
}
