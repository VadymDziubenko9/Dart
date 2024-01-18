import 'package:test/test.dart' hide test;
import 'package:webdriver/sync_io.dart';

import '../automation.dart';
import '../models/dash_portal_user.dart';
import 'logged_in_page.dart';

class ProfilePage extends LoggedInPage {
  static String pageURL = 'https:/*/profile';

  static ProfilePage open() {
    Automation.driver.get(pageURL);
    var page = ProfilePage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    waitUntilVisibleByXpath("//div[contains(@class, 'react-tel-input')]//input");
  }

  String? get firstName => Input(By.name('firstName')).value;

  set firstName(String? value) => Input(By.name('firstName')).value = value;

  String? get lastName => Input(By.name('lastName')).value;

  set lastName(String? value) => Input(By.name('lastName')).value = value;

  String? get email => Input(By.name('email')).value;

  set email(String? value) => Input(By.name('email')).value = value;

  String? get cellPhone => TelInput("//div[contains(@class, 'react-tel-input')]").value;

  set cellPhone(String? value) => TelInput("//div[contains(@class, 'react-tel-input')]").value = value;

  bool get smsNotification => Switch(By.xpath("//label[span[text()='SMS notification']]")).value;

  set smsNotification(bool value) => Switch(By.xpath("//label[span[text()='SMS notification']]")).value = value;

  bool get emailNotification => Switch(By.xpath("//label[span[text()='E-mail notification']]")).value;

  set emailNotification(bool value) => Switch(By.xpath("//label[span[text()='E-mail notification']]")).value = value;

  void verifyProfile(DashPortalUser user) {
    expect(firstName, user.firstName);
    expect(lastName, user.lastName);
    expect(email, user.email);
    expect(cellPhone, user.phone);
    expect(smsNotification, user.smsNotification);
    expect(emailNotification, user.emailNotification);
  }

  void fillProfile(DashPortalUser user) {
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    cellPhone = user.phone;
    smsNotification = user.smsNotification;
    emailNotification = user.emailNotification;
  }

  void trySubmit() => clickOnXpath("//button[@type='submit']");

  void submit() {
    trySubmit();
    waitTillBubbleMessageShown('Profile was updated');
    closeBubble();
  }
}
