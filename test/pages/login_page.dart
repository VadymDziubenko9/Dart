
import 'package:webdriver/sync_io.dart';

import '../automation.dart';
import '../models/dash_portal_user.dart';
import 'dash_list_page.dart';
import 'logged_in_page.dart';


class LoginPage extends Automation {
  static const pageURL = 'https://admin-qa.dashweek.com/sign-in';

  void waitTillPageLoaded() {
    waitUntilVisibleByXpath("//input[@name='email']");
  }

  LoginPage open() {
    Automation.driver.get(pageURL);
    waitTillPageLoaded();
    return this;
  }

  LoginPage clearAuthAndOpen() {
    Automation.driver.get(pageURL);
    if (LoggedInPage.loggedIn()) {
      LoggedInPage().logOut();
    }
    waitTillPageLoaded();
    return this;
  }

  void fillEmail(String email) {
    var input = Input(By.xpath("//input[@name='email']"));
    input.value = email;
  }

  void fillPassword(String password) {
    var input = Input(By.xpath("//input[@name='password']"));
    input.value = password;
  }

  void trySubmit() {
    clickOnXpath("//button[@type='submit']");
  }

  DashListPage submit(DashPortalUser user, {bool firstLogin = false}) {
    trySubmit();
    // if (firstLogin) {
    //   var updatePasswordPage = UpdatePasswordPage();
    //   updatePasswordPage.waitTillPageLoaded();
    //   updatePasswordPage.newPassword = user.password;
    //   updatePasswordPage.newPasswordConfirmation = user.password;
    //   updatePasswordPage.trySubmit();
    // }
    var page = DashListPage();
    page.waitTillPageLoaded();
    return page;
  }

  DashListPage loginUser(DashPortalUser user, {bool firstLogin = false}) {
    fillEmail(user.email);
    fillPassword(user.password);
    return submit(user, firstLogin: firstLogin);
  }
}
