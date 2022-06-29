
import 'package:webdriver/sync_io.dart';
import '../automation.dart';
import 'logged_in_page.dart';


abstract class CasesPage extends LoggedInPage {

  @override
  void waitTillPageLoaded() {
    super.waitTillPageLoaded();
    var casesShown =
    Automation.Try(() => waitUntilVisibleByXpath("//body/div/div/div/div[contains(@class, 'flex-col')]/div"));
    if (casesShown is Failure) {
      waitUntilVisibleByXpath("//p[text()='No case(s)']");
    }
  }

  void waitTillPageLoadedAfterTermsPublish() {
    super.waitTillPageLoaded();
    Automation.Try(() => waitUntilVisibleByXpath("//div[contains(@class,'items-center')]//h1[text()='Terms & Conditions']"));
  }

  WebElement caseTitleElement(String title) => Automation.driver
      .findElement(By.xpath("//div[@class='flex flex-col']//div/a[text()='$title']"));

}
