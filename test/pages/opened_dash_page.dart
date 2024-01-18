import '../automation.dart';
import 'dash_page.dart';

class OpenCasesPage extends CasesPage {
  static final String pageURL =
      'https://*/admin/litigation-cases';

  static OpenCasesPage open() {
    Automation.driver.get(pageURL);
    var page = OpenCasesPage();
    page.waitTillPageLoaded();
    return page;
  }

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var maybeListShown = Automation.Try(() => waitUntilVisibleByXpath(
        "//button[contains(@class, 'active') and text()='open']"));
    if (maybeListShown is Failure) {
      waitUntilVisibleByXpath("//*[@alt='No Data']");
    }
  }
}
