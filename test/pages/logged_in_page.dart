import 'dart:io';

import 'package:webdriver/async_core.dart';

import '../automation.dart';
import 'login_page.dart';
import 'profile_page.dart';


class LoggedInPage extends Automation {
  void waitTillPageLoaded() {
    sleep(Duration(milliseconds: 1500));
    waitUntilVisibleByXpath("//header//div[contains(@class,'MuiBox-root ') and ./*[contains(@class,'MuiSvgIcon-root')]]");
  }
  
  String get loggedInUserName {
    var completeText = Automation.driver
        .findElement(By.xpath( "//header//div[contains(@class,'MuiToolbar-root')]/div[2]"))
        .text
        .trim();
    return completeText.split(',').elementAt(1);
  }

  void refresh() {
    Automation.driver.refresh();
    waitTillPageLoaded();
  }

  void expandUserContextMenu() {
    if (!isVisibleByXpath("//div[@id='account-menu']//ul")) {
      clickOnXpath("//div[contains(@class,'MuiBox-root')]/*[contains(@class,'MuiSvgIcon-root')]");
      waitUntilVisibleByXpath("//div[@id='account-menu']//ul");
      sleep(Duration(milliseconds: 500));
    }
  }

  void collapseUserContextMenu() {
    if (isVisibleByXpath("//ul[@role='menu']")) {
      Automation.driver.keyboard.sendKeys(Keyboard.escape);
      waitUntilNotVisibleByXpath("//ul[@role='menu']");
    }
  }

  void selectUserContextMenuItem(String item) {
    expandUserContextMenu();
    clickOnXpath("//ul[@role='menu']/*[.='$item']");
    waitUntilNotVisibleByXpath("//div[contains(@class, 'dropdown-menu')]");
  }

  void selectMainMenuItem(String item) {
    clickOnXpath("//ul[contains(@class,'MuiList-padding')]/*[.='$item']");
    waitUntilVisibleByXpath("//a[contains(@class,'Mui-selected ') and .//span[text()='$item']]");
  }

  bool filterBarMenuItemVisible(String item) {
    return isVisibleByXpath("//ul[@role='menu']/*[text()='$item']");
  }

  ProfilePage openProfile() {
    selectUserContextMenuItem('My Profile');
    var profilePage = ProfilePage();
    sleep(Duration(milliseconds: 1000));
    profilePage.waitTillPageLoaded();
    return profilePage;
  }


  LoginPage logOut() {
    selectUserContextMenuItem('Log Out');
    var loginPage = LoginPage();
    loginPage.waitTillPageLoaded();
    sleep(Duration(milliseconds: 500));
    return loginPage;
  }


  // ReportTemplatesPage openReportTemplates() {
  //   selectUserContextMenuItem('Report Templates');
  //   var templatesPage = ReportTemplatesPage();
  //   templatesPage.waitTillPageLoaded();
  //   return templatesPage;
  // }
  //
  // ReportSectionTemplatesPage openReportSectionTemplates() {
  //   selectUserContextMenuItem('Report Section Templates');
  //   var templatesPage = ReportSectionTemplatesPage();
  //   templatesPage.waitTillPageLoaded();
  //   return templatesPage;
  // }
  //
  // TermsAndConditionsPage openTermsAndConditions() {
  //   selectUserContextMenuItem('Terms and Conditions');
  //   var termsAndConditionsPage = TermsAndConditionsPage();
  //   termsAndConditionsPage.waitTillPageLoaded();
  //   return termsAndConditionsPage;
  // }
  //
  // ClientAccountsPage openClientAccounts() {
  //   selectUserContextMenuItem('Client Accounts');
  //   var result = ClientAccountsPage();
  //   result.waitTillPageLoaded();
  //   return result;
  // }
  //
  // AuthorRegistryPage openAuthorRegistry() {
  //   selectUserContextMenuItem('Author Registry');
  //   var result = AuthorRegistryPage();
  //   result.waitTillPageLoaded();
  //   sleep(Duration(seconds: 1));
  //   return result;
  // }
  //
  // AdminBillingPage openAdminBillingPage() {
  //   selectUserContextMenuItem('Billing');
  //   var result = AdminBillingPage();
  //   result.waitTillPageLoaded();
  //   return result;
  // }
  //
  // CasePortalUsersPage openCasePortalUsers() {
  //   selectUserContextMenuItem('Case Portal Users');
  //   var result = CasePortalUsersPage();
  //   result.waitTillPageLoaded();
  //   return result;
  // }

  static bool loggedIn() =>
      Automation().isVisibleByXpath("//header//div[contains(@class, 'MuiAvatar-root')]", Duration(milliseconds: 1500));
}
