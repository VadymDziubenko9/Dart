import '../automation.dart';
import 'logged_in_page.dart';

class ExpensesPage extends LoggedInPage {
  static final String pageURL = 'https://admin-qa.dashweek.com/admin/expenses';

  static ExpensesPage open() {
    Automation.driver.get(pageURL);
    var page = ExpensesPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath(
        "//div[contains(@class,'MuiBox-root') and ./p[text()='Expenses']]"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }
}
