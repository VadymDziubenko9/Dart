
import 'dart:io';

import 'package:webdriver/async_core.dart';

import '../automation.dart';
import '../models/payroll_list.dart';
import '../models/payroll_reservation_items_list.dart';
import '../utils.dart';
import 'logged_in_page.dart';

class PayrollPage extends LoggedInPage {
  static final String pageURL = 'https://*/payroll';

  static PayrollPage open() {
    Automation.driver.get(pageURL);
    var page = PayrollPage();
    page.waitTillPageLoaded();
    return page;
  }


  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    waitUntilVisibleByXpath("//div[contains(@class,'MuiBox-root') and ./p[text()='Payroll']]");
    var maybeListShown = Automation.Try(() =>
        waitUntilVisibleByXpath(
            "//div[contains(@id,'content') and .//div[@id='panel1a-header'] and .//div[@id='panel2a-header']]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }

  static final String _startDateXpath =
      "//div[contains(@class,'MuiFormControl-root') and ./label[text()='Start date']]";
  
  static final String _endDateXpath =
      "//div[contains(@class,'MuiFormControl-root') and ./label[text()='End date']]";

  static final String _saveDateXpath =
      "//div[contains(@class,'MuiPaper-root')]//button[text()='OK']";
  
  static final String _dateFormXpath =
      "//div[contains(@class,'MuiPaper-root ') and .//span[text()='Start date']]";

  set payrollStartDate(DateTime? value) {
    var isVisible = isVisibleByXpath(_startDateXpath) && isVisibleByXpath(_endDateXpath);
    clickOnXpath(_startDateXpath);
    if(isVisibleByXpath(_dateFormXpath)){
      clickOnXpath("//button[contains(@aria-label,'input view')]");
      if(isVisibleByXpath("//div[contains(@class,'MuiDialogContent-root')]")){
        var targetXpath = isVisible
            ? "//div[contains(@class,'MuiDialogContent-root')]//input"
            : "//div[contains(@class,'MuiDialogContent-root') and .//div[contains(@class,'MuiFormControl-root')]]//input";
        var dateInput = DateInput(By.xpath(targetXpath));
        dateInput.value = value;
      }
    }
    clickOnXpath(_saveDateXpath);
    waitUntilNotVisibleByXpath(_dateFormXpath);
    sleep(Duration(seconds: 1));
  }

  set payrollEndDate(DateTime? value) {
    var isVisible = isVisibleByXpath(_startDateXpath) && isVisibleByXpath(_endDateXpath);
    clickOnXpath(_endDateXpath);
    if(isVisibleByXpath("//div[contains(@class,'MuiPaper-root ') and .//span[text()='End date']]")){
      clickOnXpath("//button[contains(@aria-label,'input view')]");
      if(isVisibleByXpath("//div[contains(@class,'MuiDialogContent-root')]")){
        var targetXpath = isVisible
            ? "//div[contains(@class,'MuiDialogContent-root')]//input"
            : "//div[contains(@class,'MuiDialogContent-root') and .//div[contains(@class,'MuiFormControl-root')]]//input";
        var dateInput = DateInput(By.xpath(targetXpath));
        dateInput.value = value;
      }
    }
    clickOnXpath(_saveDateXpath);
    waitUntilNotVisibleByXpath(_dateFormXpath);
    sleep(Duration(seconds: 1));
  }

  DateTime? get payrollDate {
    var isVisible = isVisibleByXpath(_startDateXpath) && isVisibleByXpath(_endDateXpath);
    var targetXpath = isVisible
        ? "$_startDateXpath//input"
        : "$_endDateXpath//input";
    var dateInput = DateInput(By.xpath(targetXpath));
    return dateInput.value;
  }

  void addPayrollData(Payroll date) {
    fillInPayrollData(date);
  }

  void fillInPayrollData(Payroll date) {
    payrollStartDate = date.startDate;
    payrollEndDate = date.endDate;
  }

  List<PayrollReservationList> parseItems() {
    if(isVisibleByXpath("//div[contains(@class,'MuiBox-root') and ./p[text()='Payroll']]")){
      clickOnXpath("//div[@id='panel1a-header']/div[contains(@class,'MuiAccordionSummary-contentGutters')]");
      waitUntilVisibleByXpath("//div[@id='panel1a-header']/div[contains(@class,'Mui-expanded')][1]");
      sleep(Duration(seconds: 2));
    }
    return Automation.driver.findElements(By.xpath("//div[@id='panel1a-content']//div[contains(@class,'MuiCard-root')]")).map((item) {
      scrollIntoView(item);
      var block_1 = ".//div[contains(@class,'MuiGrid-grid-sm-4')]";
      var block_2 = ".//div[contains(@class,'MuiGrid-grid-sm-3')]";
      var agent = item.findElement(By.xpath("$block_1[1]/p[2]")).text;
      var owner = item.findElement(By.xpath("$block_1[2]/p[2]")).text;
      var guest = item.findElement(By.xpath("$block_1[3]/p[2]")).text;
      var ownerRate = item.findElement(By.xpath("$block_2[1]/p[2]")).text;
      var guestRate = item.findElement(By.xpath("$block_2[2]/p[2]")).text;
      var spread = item.findElement(By.xpath("$block_2[3]/p[2]")).text;
      var guestPaymentDate = dateInputValueGetFormat.parse(item.findElement(By.xpath("$block_2[4]/p[2]")).text);
      return PayrollReservationList(
            (b) => b
          ..agent = agent
          ..owner = owner
          ..guest = guest
          ..ownerRate = ownerRate
          ..guestRate = guestRate
          ..spread = spread
          ..guestPaymentDate = guestPaymentDate,
      );
    }).toList();
  }

}
