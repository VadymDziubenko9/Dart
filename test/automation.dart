import 'dart:convert';
import 'dart:io';

import 'package:charcode/ascii.dart';
import 'package:webdriver/sync_io.dart';

import 'test_config.dart';
import 'utils.dart';

abstract class Result<T> {
  T get value;
}

class Success<T> extends Result<T> {
  final T _value;

  Success(this._value);

  @override
  T get value => _value;
}

class Failure<T> extends Result<T> {
  @override
  T get value => throw 'Failure does not have value';
}

class WaitUntilAvailableInDomError extends Error {
  final By selector;
  final Duration maxWait;

  WaitUntilAvailableInDomError(this.selector, this.maxWait);

  @override
  String toString() => 'Element $selector was not available in DOM after $maxWait time passed';
}

class WaitUntilPredicateTrueError extends Error {
  final Duration maxWait;

  WaitUntilPredicateTrueError(this.maxWait);

  @override
  String toString() => 'Predicate was not true after $maxWait time passed';
}

class WaitUntilVisibleError extends Error {
  final By selector;
  final Duration maxWait;

  WaitUntilVisibleError(this.selector, this.maxWait);

  @override
  String toString() => 'Element $selector was not visible after $maxWait time passed';
}

class WaitUntilEnabledError extends Error {
  final By selector;
  final Duration maxWait;

  WaitUntilEnabledError(this.selector, this.maxWait);

  @override
  String toString() => 'Element $selector was not enabled after $maxWait time passed';
}

class WaitUntilInputHasValueError extends Error {
  final By selector;
  final Duration maxWait;

  WaitUntilInputHasValueError(this.selector, this.maxWait);

  @override
  String toString() => 'Element $selector still had no @value after $maxWait time passed';
}

class WaitUntilElementHasNonEmptyTextError extends Error {
  final By selector;
  final Duration maxWait;

  WaitUntilElementHasNonEmptyTextError(this.selector, this.maxWait);

  @override
  String toString() => 'Element $selector still was not visible or had empty text after $maxWait time passed';
}

class WaitUntilElementHasParticularValueError extends Error {
  final By selector;
  final String value;
  final Duration maxWait;

  WaitUntilElementHasParticularValueError(this.selector, this.value, this.maxWait);

  @override
  String toString() =>
      'Element $selector still was not visible or had value different from $value after $maxWait time passed';
}

class WaitUntilNotVisibleError extends Error {
  final By selector;
  final Duration maxWait;

  WaitUntilNotVisibleError(this.selector, this.maxWait);

  @override
  String toString() => 'Element was still visible $selector after $maxWait time passed';
}

class WaitUntilPageCardImageLoadedError extends Error {
  final Duration maxWait;

  WaitUntilPageCardImageLoadedError(this.maxWait);

  @override
  String toString() => 'Page card image was not loaded after $maxWait time passed';
}

class waitTillStapleSecondaryXButtonShownError extends Error {
  final Duration maxWait;

  waitTillStapleSecondaryXButtonShownError(this.maxWait);

  @override
  String toString() => 'Page card secondary staple button was not loaded after $maxWait time passed';
}

class WaitUntilNextModalPageLoadedError extends Error {
  final Duration maxWait;

  WaitUntilNextModalPageLoadedError(this.maxWait);

  @override
  String toString() => 'Next modal page was not loaded after $maxWait time passed';
}

class WaitUntilPreviousModalPageLoadedError extends Error {
  final Duration maxWait;

  WaitUntilPreviousModalPageLoadedError(this.maxWait);

  @override
  String toString() => 'Previous modal page was not loaded after $maxWait time passed';
}

class Automation {
  static bool driverInitialized = false;
  static late WebDriver driver;
  static Process? _chromeDriverProcess;

  static Duration? maxWait;
  static const Duration POLLING_INTERVAL = Duration(milliseconds: 400);

  static void killChromeDriver() {
    Automation.driver.quit();
    driverInitialized = false;
    sleep(Duration(seconds: 3));
    if (_chromeDriverProcess != null) {
      _chromeDriverProcess?.kill(ProcessSignal.sigterm);
      sleep(Duration(seconds: 3));
      _chromeDriverProcess = null;
    }
  }

  static Future<void> initDriver() async {
    if (!driverInitialized) {
      var isSlave = Platform.environment.containsKey('JENKINS_SLAVE');

      var configName = isSlave ? 'slave.yaml' : 'local.yaml';
      var config = TestConfiguration(configName);

      if (_chromeDriverProcess == null) {
        _chromeDriverProcess = await Process.start(
          config.driverPath,
          ['--port=9998', '--url-base=/'],
        );

        await for (String browserOut in const LineSplitter().bind(utf8.decoder.bind(_chromeDriverProcess!.stdout))) {
          if (browserOut.contains('Starting ChromeDriver')) {
            break;
          }
        }

        sleep(Duration(seconds: 10));
      }

      var capabilities = Capabilities.chrome
        ..[Capabilities.chromeOptions] = {
          'args': [
            if (config.headless) ...[
              '--headless',
              '--no-sandbox',
              '--disable-dev-shm-usage',
              '--disable-gpu',
            ],
            '--window-size=1920,1080',
            '--lang=en-US',
          ]
        };

      driver = createDriver(
        uri: Uri.parse('http://localhost:9998/'),
        desired: capabilities,
      );

      maxWait = Duration(milliseconds: config.maxWaitMillis);

      var tabsNumber = driver.windows.length;
      for (var i = 0; i < tabsNumber - 1; i++) {
        var tab = driver.windows.elementAt(i);
        tab.setAsActive();
        tab.close();
      }
      driver.window.setAsActive();
      driver.window.maximize();
      driverInitialized = true;
    }
  }

  static void terminateChrome() {
    _chromeDriverProcess?.kill(ProcessSignal.sigkill);
  }

  void waitUntilPredicateTrue(
      bool Function() predicate, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    while (!predicate()) {
      var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
      if (!remainingWait.isNegative) {
        sleep(pollingInterval);
        maxWait = remainingWait;
      } else {
        throw WaitUntilPredicateTrueError(initialMaxWait!);
      }
    }
  }

  WebElement waitUntilAvailableInDomBy(
      By selector, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    WebElement attempt() => driver.findElement(selector);
    var notFound = true;
    late WebElement result;
    while (notFound) {
      try {
        result = attempt();
        notFound = false;
      } catch (error) {
        if (error is! NoSuchElementException) {
          rethrow;
        }
        var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
        if (!remainingWait.isNegative) {
          sleep(pollingInterval);
          maxWait = remainingWait;
        } else {
          throw WaitUntilAvailableInDomError(selector, initialMaxWait!);
        }
      }
    }
    return result;
  }

  bool isAvailableInDomBy(By selector) {
    try {
      waitUntilAvailableInDomBy(selector,
          maxWait: Duration(milliseconds: 120), pollingInterval: Duration(milliseconds: 30));
      return true;
    } on WaitUntilAvailableInDomError catch (_) {
      return false;
    } catch (any) {
      rethrow;
    }
  }

  bool isAvailableInDomByXpath(String xpath) => isAvailableInDomBy(By.xpath(xpath));

  WebElement waitUntilVisibleBy(
      By selector, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    var notFound = true;
    WebElement? result;
    while (notFound) {
      try {
        var element = driver.findElement(selector);
        if (element.displayed) {
          notFound = false;
          result = element;
        } else {
          throw NoSuchElementException(400, 'element available in DOM but not displayed');
        }
      } catch (error) {
        if ((error is! NoSuchElementException) && (error is! StaleElementReferenceException)) {
          rethrow;
        }
        var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
        if (!remainingWait.isNegative) {
          sleep(pollingInterval);
          maxWait = remainingWait;
        } else {
          throw WaitUntilVisibleError(selector, initialMaxWait!);
        }
      }
    }
    return result!;
  }

  WebElement waitUntilVisibleByXpath(
      String xpath, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilVisibleBy(By.xpath(xpath), maxWait: maxWait, pollingInterval: pollingInterval);

  WebElement waitUntilVisibleByXpathStaple(
      String xpath, Duration? maxWait, {
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilVisibleBy(By.xpath(xpath), maxWait: maxWait, pollingInterval: pollingInterval);

  WebElement waitUntilVisibleById(
      String id, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilVisibleBy(By.id(id), maxWait: maxWait, pollingInterval: pollingInterval);

  WebElement waitUntilVisibleByClassName(
      String className, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilVisibleBy(By.className(className), maxWait: maxWait, pollingInterval: pollingInterval);

  WebElement waitUntilEnabledBy(
      By selector, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    WebElement attempt() => driver.findElement(selector);
    var notFound = true;
    WebElement? result;
    while (notFound) {
      try {
        var element = attempt();
        if (element.enabled) {
          notFound = false;
          result = element;
        } else {
          throw NoSuchElementException(400, 'element available in DOM but not displayed');
        }
      } catch (error) {
        if ((error is! NoSuchElementException) && (error is! StaleElementReferenceException)) {
          rethrow;
        }
        var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
        if (!remainingWait.isNegative) {
          sleep(pollingInterval);
          maxWait = remainingWait;
        } else {
          throw WaitUntilEnabledError(selector, initialMaxWait!);
        }
      }
    }
    return result!;
  }

  WebElement waitUntilEnabledByXpath(
      String xpath, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilEnabledBy(By.xpath(xpath), maxWait: maxWait, pollingInterval: pollingInterval);

  void waitUntilNotVisibleBy(
      By selector, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    WebElement attempt() => driver.findElement(selector);
    var found = true;
    while (found) {
      try {
        var element = attempt();
        if (element.displayed) {
          var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
          if (!remainingWait.isNegative) {
            sleep(pollingInterval);
            maxWait = remainingWait;
          } else {
            throw WaitUntilNotVisibleError(selector, initialMaxWait!);
          }
        } else {
          throw NoSuchElementException(404, 'element not displayed anymore');
        }
      } on WaitUntilNotVisibleError {
        rethrow;
      } on NoSuchElementException {
        return;
      } on StaleElementReferenceException {
        //do nothing
      } catch (any) {
        rethrow;
      }
    }
  }

  void waitUntilNotVisibleByXpath(
      String xpath, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilNotVisibleBy(By.xpath(xpath), maxWait: maxWait, pollingInterval: pollingInterval);

  void waitUntilNotVisibleById(
      String id, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilNotVisibleBy(By.id(id), maxWait: maxWait, pollingInterval: pollingInterval);

  void waitUntilNotVisibleByClassName(
      String className, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) =>
      waitUntilNotVisibleBy(By.className(className), maxWait: maxWait, pollingInterval: pollingInterval);

  bool isVisibleBy(By selector, [Duration maxWait = const Duration(milliseconds: 120)]) {
    try {
      waitUntilVisibleBy(selector, maxWait: maxWait, pollingInterval: Duration(milliseconds: 30));
      return true;
    } on WaitUntilVisibleError catch (_) {
      return false;
    } catch (any) {
      rethrow;
    }
  }

  bool isVisibleByXpath(String xpath, [Duration maxWait = const Duration(milliseconds: 120)]) =>
      isVisibleBy(By.xpath(xpath), maxWait);

  void clickOn(By selector) => waitUntilAvailableInDomBy(selector).click();

  bool isVisibleByXpathInsideParent(WebElement parent, String xpath) {
    try {
      parent.findElement(By.xpath(xpath));
      return true;
    } on NoSuchElementException catch (_) {
      return false;
    } catch (_) {
      rethrow;
    }
  }

  void clickOnXpath(String xpath) => clickOn(By.xpath(xpath));

  void clickOnId(String id) => clickOn(By.id(id));

  void clickOnClassName(String className) => clickOn(By.className(className));

  void moveMouseAndClickOnXpath(String xpath) {
    driver.mouse.moveTo(element: driver.findElement(By.xpath(xpath)));
    driver.mouse.click();
  }

  String? extractOptionalText(By selector) {
    String? result;
    try {
      var t = Automation.driver.findElement(selector).text;
      result = (t.isNotEmpty && t != '-') ? t : null;
    } on NoSuchElementException catch (_) {
    } catch (any) {
      //swallow deliberately
    }
    return result;
  }

  /*
  * returns null if @parent does not have the child specified by @selector
  * returns child's text otherwise
  * */
  String? extractOptionalChildText(WebElement parent, By selector) {
    String? result;
    try {
      var t = parent.findElement(selector).text;
      result = (t.isNotEmpty && t != '-') ? t : null;
    } on NoSuchElementException catch (_) {
    } catch (any) {
      //swallow deliberately
    }
    return result;
  }

  String? extractOptionalChildTextByIndex(WebElement parent, By selector, int index) {
    String? result;
    try {
      var t = parent.findElements(selector)[index].text;
      result = (t.isNotEmpty && t != '-') ? t : null;
    } on NoSuchElementException catch (_) {
    } catch (any) {
      //swallow deliberately
    }
    return result;
  }

  int parseNumber(WebElement parent, String xpath) {
    var rawValue = parent.findElement(By.xpath(xpath)).text;
    var value = rawValue == '-' ? 0 : int.parse(rawValue);
    return value;
  }

  WebElement? findOptionalChild(WebElement parent, By selector) {
    WebElement? result;
    try {
      result = parent.findElement(selector);
    } on NoSuchElementException catch (_) {
    } catch (any) {
      //swallow deliberately
    }
    return result;
  }

  void scrollIntoViewCaseSearch(WebElement element) {
    driver.execute('arguments[0].scrollIntoView(true);', [element]);
    sleep(Duration(milliseconds: 50));
  }

  void scrollIntoView(WebElement element) {
    try {
      driver.execute('arguments[0].scrollIntoView(true);', [element]);
    } catch (e) {
      var refreshedElement = driver.findElement(By.xpath(element.locator.value));
      driver.execute('arguments[0].scrollIntoView(true);', [refreshedElement]);
    } finally {
      sleep(Duration(milliseconds: 50));
    }
  }

  String? getElementAttribute(WebElement element, String attribute) {
    try {
      return element.attributes[attribute];
    } catch (e) {
      var refreshedElement = driver.findElement(By.xpath(element.locator.value));
      return refreshedElement.attributes[attribute];
    }
  }

  void scrollToTop() => driver.execute('window.scrollTo(0, 0);', []);

  void scrollVerticallyBy(int offset) => Automation.driver.execute('window.scrollBy(0, arguments[0]);', [offset]);

  void waitUntilInputHasValue(
      By selector, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    var notFound = true;
    while (notFound) {
      try {
        var input = driver.findElement(selector);
        if (input.properties['value'] != null && input.properties['value']!.isNotEmpty) {
          notFound = false;
        } else {
          throw NoSuchElementException(400, 'not found yet');
        }
      } catch (error) {
        if ((error is! NoSuchElementException) && (error is! StaleElementReferenceException)) {
          rethrow;
        }
        var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
        if (!remainingWait.isNegative) {
          sleep(pollingInterval);
          maxWait = remainingWait;
        } else {
          throw WaitUntilInputHasValueError(selector, initialMaxWait!);
        }
      }
    }
  }

  void waitUntilElementHasNonEmptyText(
      By selector, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    var notFound = true;
    while (notFound) {
      try {
        var elem = driver.findElement(selector);
        if (elem.text.isNotEmpty) {
          notFound = false;
        } else {
          throw NoSuchElementException(400, 'not found yet');
        }
      } catch (error) {
        if ((error is! NoSuchElementException) && (error is! StaleElementReferenceException)) {
          rethrow;
        }
        var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
        if (!remainingWait.isNegative) {
          sleep(pollingInterval);
          maxWait = remainingWait;
        } else {
          throw WaitUntilElementHasNonEmptyTextError(selector, initialMaxWait!);
        }
      }
    }
  }

  void waitUntilElementHasParticularValue(
      By selector,
      String value, {
        Duration? maxWait,
        Duration pollingInterval = POLLING_INTERVAL,
      }) {
    maxWait ??= Automation.maxWait;
    var initialMaxWait = maxWait;
    var notFound = true;
    while (notFound) {
      try {
        var elem = driver.findElement(selector);
        if (elem.properties['value'] == value) {
          notFound = false;
        } else {
          throw NoSuchElementException(400, 'not found yet');
        }
      } catch (error) {
        if ((error is! NoSuchElementException) && (error is! StaleElementReferenceException)) {
          rethrow;
        }
        var remainingWait = Duration(milliseconds: maxWait!.inMilliseconds - pollingInterval.inMilliseconds);
        if (!remainingWait.isNegative) {
          sleep(pollingInterval);
          maxWait = remainingWait;
        } else {
          throw WaitUntilElementHasParticularValueError(selector, value, initialMaxWait!);
        }
      }
    }
  }

  Window openNewBrowserTab() {
    var oldHandles = Automation.driver.windows.toSet();
    Automation.driver.execute('window.open()', []);
    var newHandles = Automation.driver.windows.toSet();
    var tabHandle = newHandles.difference(oldHandles).elementAt(0);
    tabHandle.setAsActive();
    return tabHandle;
  }

  Window currentBrowserTabHandle() => Automation.driver.window;

  static Result<T> Try<T>(T Function() body) {
    try {
      var result = body();
      return Success(result);
    } catch (_) {
      return Failure();
    }
  }

  void waitTillBubbleMessageShown(String message,
      {String? alternativeMessage, Duration maxWait = const Duration(seconds: 8)}) {
    var xpath = alternativeMessage == null
        ? "//div[@id='notistack-snackbar' and text()='$message']"
        : "//div[@id='notistack-snackbar' and text()='$message' or text()='$alternativeMessage']";
    waitUntilVisibleByXpath(xpath, maxWait: maxWait);
    sleep(Duration(milliseconds: 1500));
  }

  void waitTillBubbleMessageShownByInclusion(String message,
      {String? alternativeMessage, Duration maxWait = const Duration(seconds: 4)}) {
    var xpath = alternativeMessage == null
        ? "//div[@id='notistack-snackbar' and contains(text(), '$message')]"
        : "//div[@id='notistack-snackbar' and (contains(text(), '$message') or contains(text(), '$alternativeMessage'))]";
    waitUntilVisibleByXpath(xpath, maxWait: maxWait);
    sleep(Duration(milliseconds: 800));
  }

  void closeBubble() {
    waitUntilVisibleByXpath(
        "//div[./div[@id='notistack-snackbar']]//button[contains(@class, 'MuiButtonBase-root')]/span");
    moveMouseAndClickOnXpath("//div[./div[@id='notistack-snackbar']]//button[contains(@class, 'MuiButtonBase-root')]/span");
    waitUntilNotVisibleByXpath(
        "//div[./div[@id='notistack-snackbar']]//button[contains(@class, 'MuiButtonBase-root')]");
  }

  void closeAllBubbles() {
    while (isVisibleByXpath(
        "//div[./div[@id='notistack-snackbar']]//button[contains(@class, 'MuiButtonBase-root')]/span")) {
      clickOnXpath("//div[./div[@id='notistack-snackbar']]//button[contains(@class, 'MuiButtonBase-root')]/span");
      sleep(Duration(milliseconds: 800));
    }
  }
}

class Input extends Automation {
  final By selector;
  final WebElement _input;

  Input._(this.selector, this._input);

  factory Input(By selector) {
    var input = Automation.driver.findElement(selector);
    return Input._(selector, input);
  }

  set value(String? value) {
    if (value == null) {
      clearSlowly();
    } else {
      clearSlowly();
      _input.sendKeys(value);
    }
  }

  String? get value {
    return _input.properties['value'];
  }

  void clear() => clearSlowly();

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_input]);

  void sendKeys(String keys) => _input.sendKeys(keys);

  void typeNaturally(String? value) {
    if (value != null) {
      value.split('').forEach((symbol) {
        _input.sendKeys(symbol);
        sleep(Duration(milliseconds: 300));
      });
      sleep(Duration(milliseconds: 500));
    }
  }

  void clearSlowly() {
    var lValue = value;
    if (lValue != null) {
      var length = lValue.length;
      for (var i = 0; i < length; i++) {
        _input.sendKeys(String.fromCharCode($bs));
        // _input.sendKeys(String.fromCharCode($del));
      }
      sleep(Duration(milliseconds: 100));
    }
  }
}

class TelInput extends Input {
  final String _xpath;
  TelInput(this._xpath) : super._(By.xpath(_xpath), Automation.driver.findElement(By.xpath('$_xpath//input')));

  void _selectUkraineCountryCode() {
    Automation.driver.findElement(By.xpath("$_xpath//div[contains(@class, 'flag-dropdown')]")).click();
    waitUntilVisibleByXpath("//ul[normalize-space(@class='country-list')]");
    clickOnXpath("//li[@data-country-code='ua']");
    waitUntilVisibleByXpath("$_xpath//div[@class='selected-flag' and @title='Ukraine: + 380']");
  }

  @override
  set value(String? value) {
    clearSlowly();
    if (value != null && value.startsWith('380')) {
      _selectUkraineCountryCode();
      value = value.replaceFirst('380', '');
    }
    typeNaturally(value);
  }

  @override
  String? get value => super
      .value;
      // ?.replaceAll('-', '')
      // .replaceAll(' ', '')
      // .replaceAll('(', '')
      // .replaceAll(')', '')
      // .replaceAll('+', '')
      // .trim();

  @override
  void clearSlowly() {
    var lValue = value;
    if (lValue != null) {
      var length = lValue.length + 2;
      for (var i = 0; i < length; i++) {
        _input.sendKeys(String.fromCharCode($bs));
        _input.sendKeys(String.fromCharCode($del));
        sleep(Duration(milliseconds: 100));
      }
      sleep(Duration(milliseconds: 100));
    }
  }
}

class Select {
  final String xpath;
  final WebElement _select;

  Select._(this.xpath, this._select);

  factory Select(String xpath) {
    var select = Automation.driver.findElement(By.xpath(xpath));
    return Select._(xpath, select);
  }

  bool optionAvailable(String value) => Automation().isVisibleByXpath("$xpath/option[text()='$value']");

  void selectOptionByText(String value) {
    _select.click();
    var targetOptionXpath = "$xpath/option[text()='$value']";
    var automation = Automation();
    automation.waitUntilVisibleByXpath(targetOptionXpath);
    automation.clickOnXpath(targetOptionXpath);
  }

  String get selectedOption {
    return _select.findElements(By.tagName('option')).firstWhere((option) => option.selected).text;
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_select]);

  Iterable<String> availableOptions() => Automation.driver.findElements(By.xpath('$xpath/option')).map((o) => o.text);
}

class Switch {
  final By selector;

  WebElement get _checkbox => _wrapper.findElement(By.xpath(".//input[@type='checkbox']"));

  WebElement get _label => _wrapper.findElement(By.xpath("./span[contains(@class, 'MuiFormControlLabel-label')]"));

  WebElement get _wrapper => Automation.driver.findElement(selector);

  Switch(this.selector);

  void check() {
    if (!_checkbox.selected) _label.click();
    sleep(Duration(milliseconds: 500));
  }

  void uncheck() {
    if (_checkbox.selected) _label.click();
    sleep(Duration(milliseconds: 500));
  }

  set value(bool value) {
    if (value) {
      check();
    } else {
      uncheck();
    }
  }

  bool get value => _checkbox.selected;

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_checkbox]);

  void click() => _checkbox.click();

  String get label => _label.text;

  bool get enabled => _checkbox.enabled;
}

class Checkbox {
  final By? selector;
  final WebElement _checkbox;

  Checkbox._(this.selector, this._checkbox);

  factory Checkbox.fromSelector(By selector) {
    var checkbox = Automation.driver.findElement(selector);
    return Checkbox._(selector, checkbox);
  }

  factory Checkbox.fromInput(WebElement input) {
    return Checkbox._(null, input);
  }

  void check() {
    if (!_checkbox.selected) _checkbox.click();
  }

  void uncheck() {
    if (_checkbox.selected) _checkbox.click();
  }

  set value(bool value) {
    if (value) {
      check();
    } else {
      uncheck();
    }
  }

  bool get value => _checkbox.selected;

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_checkbox]);

  void click() => _checkbox.click();
}

class TextArea {
  final By selector;
  final WebElement _textArea;

  TextArea._(this.selector, this._textArea);

  factory TextArea(By selector) {
    var textArea = Automation.driver.findElement(selector);
    return TextArea._(selector, textArea);
  }

  set value(String? value) {
    clearSlowly();
    if (value != null) {
      _textArea.sendKeys(value);
    }
  }

  String get value => _textArea.text;

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_textArea]);

  void sendKeys(String keys) => _textArea.sendKeys(keys);

  void clearSlowly() {
    var length = value.length;
    for (var i = 0; i < length; i++) {
      _textArea.sendKeys(String.fromCharCode($bs));
      sleep(Duration(milliseconds: 50));
    }
    sleep(Duration(milliseconds: 100));
  }
}

class MuiSingleSelect {
  final String xpath;
  final WebElement _container;

  MuiSingleSelect._(this.xpath, this._container);

  factory MuiSingleSelect(String xpath) {
    var container = Automation.driver.findElement(By.xpath(xpath));
    return MuiSingleSelect._(xpath, container);
  }

  set value(String value) {
    var automation = Automation();
    Automation.driver.mouse.moveTo(element: _container);
    Automation.driver.mouse.click();
    automation.waitUntilVisibleByXpath("//div[@class='MuiPopover-root']");
    var option =
    Automation.driver.findElement(By.xpath("//ul[contains(@class, 'MuiMenu-list')]/li[text()[1]='$value']"));
    automation.scrollIntoView(option);
    automation.waitUntilVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]/li[text()[1]='$value']");
    sleep(Duration(milliseconds: 200));
    automation.clickOnXpath("//ul[contains(@class, 'MuiMenu-list')]/li[text()[1]='$value']");
    automation.waitUntilNotVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
    automation
        .waitUntilAvailableInDomBy(By.xpath("$xpath//div[contains(@class, 'MuiSelect-select') and text()='$value']"));
  }

  String get value {
    return _container.findElement(By.xpath(".//div[contains(@class, 'MuiSelect-select')]")).text;
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_container]);

  void clear() {
    _container.click();
    var automation = Automation();
    automation.waitUntilVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
    sleep(Duration(milliseconds: 500));
    automation.clickOnXpath("//ul[contains(@class, 'MuiMenu-list')]/li[contains(., 'Choose')]");
    automation.waitUntilNotVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
  }

  Iterable<String> get availableOptions {
    _container.click();
    var automation = Automation();
    automation.waitUntilVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
    sleep(Duration(milliseconds: 500));
    var optionsNumber = Automation.driver.findElements(By.xpath("//ul[contains(@class, 'MuiMenu-list')]/li")).length;
    var result = <String>[];
    for (var i = 1; i <= optionsNumber; i++) {
      result.add(Automation.driver.findElement(By.xpath("//ul[contains(@class, 'MuiMenu-list')]/li[$i]")).text);
    }
    Automation.driver.keyboard.sendKeys(Keyboard.escape);
    automation.waitUntilNotVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
    return result;
  }
}

class MuiMultiSelect {
  final String xpath;
  final WebElement _container;
  final bool defaultAllChip;

  MuiMultiSelect._(this.xpath, this._container, this.defaultAllChip);

  factory MuiMultiSelect(String xpath, {bool defaultAllChip = false}) {
    var container = Automation.driver.findElement(By.xpath(xpath));
    return MuiMultiSelect._(xpath, container, defaultAllChip);
  }

  set values(Iterable<String> values) {
    var automation = Automation();
    clear();
    for (var value in values) {
      var input = Automation.driver.findElement(By.xpath('$xpath//input'));
      input.click();
      sleep(Duration(milliseconds: 500));
      var target = automation.waitUntilVisibleByXpath(
          "//div[contains(@class, 'MuiAutocomplete-popper')]//ul/li[text()='$value' or div[text()='$value']]");
      target.click();
      automation.waitUntilVisibleByXpath("$xpath//div[contains(@class, 'MuiChip-root') and span[text()='$value']]");
    }
  }

  Iterable<String> get values {
    return _container.findElements(By.xpath(".//div[contains(@class, 'MuiChip-root')]/span")).map((e) => e.text);
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_container]);

  void clear() {
    var automation = Automation();

    if (values.isNotEmpty) {
      for (var value in values) {
        if (!(value == 'All' && defaultAllChip)) {
          Automation.driver
              .findElement(
              By.xpath("$xpath//div[contains(@class, 'MuiChip-root') and span[text()='$value']]/*[name()='svg']"))
              .click();
          automation
              .waitUntilNotVisibleByXpath("$xpath//div[contains(@class, 'MuiChip-root') and span[text()='$value']]");
        }
      }
    }
  }

  Iterable<String> get availableOptions {
    var automation = Automation();
    automation.clickOnXpath('$xpath//input');
    automation.waitUntilVisibleByXpath("//div[contains(@class, 'MuiAutocomplete-popper')]");
    return Automation.driver
        .findElements(By.xpath("//div[contains(@class, 'MuiAutocomplete-popper')]//ul/li"))
        .map((e) => e.text);
  }
}

class MuiMultiSelectWithoutChips {
  final String xpath;
  final WebElement _container;

  MuiMultiSelectWithoutChips._(this.xpath, this._container);

  factory MuiMultiSelectWithoutChips(String xpath) {
    var container = Automation.driver.findElement(By.xpath(xpath));
    return MuiMultiSelectWithoutChips._(xpath, container);
  }

  set values(Iterable<String> values) {
    var automation = Automation();
    clear();
    for (var value in values) {
      Automation.driver.findElement(By.xpath("$xpath//span[@class='MuiTouchRipple-root']/parent::button[@title='Open']")).click();
      automation.waitUntilVisibleByXpath("//div[contains(@class, 'MuiAutocomplete-paper')]//ul");
      sleep(Duration(milliseconds: 500));
      var target =
      automation.waitUntilVisibleByXpath("//div[contains(@class,'MuiAutocomplete-paper')]//ul/li[text()='$value']");
      target.click();
      automation.waitUntilVisibleByXpath(
          "//div[@role='button']/span[text()='$value']");
      sleep(Duration(milliseconds: 500));
    }
    Automation.driver.keyboard.sendKeys(Keyboard.escape);
    automation.waitUntilNotVisibleByXpath("//div[contains(@class, 'MuiPopover-root')]//ul");
  }

  set valuesOfOptions(Iterable<String> values) {
    var automation = Automation();
    for (var value in values) {
      Automation.driver.findElement(By.xpath("$xpath//button[@aria-label='Open']")).click();
      automation.waitUntilVisibleByXpath("//div[contains(@class, 'MuiAutocomplete-paper')]//ul");
      sleep(Duration(milliseconds: 500));
      var target =
      automation.waitUntilVisibleByXpath("//div[contains(@class,'MuiAutocomplete-paper')]//ul/li[text()='$value']");
      target.click();
      automation.waitUntilVisibleByXpath("//div[@role='button']/span[text()='$value']");
      sleep(Duration(milliseconds: 500));
    }
    automation.waitUntilNotVisibleByXpath("//div[contains(@class, 'MuiPopover-root')]//ul");
  }

  Iterable<String> get values {
    var text = _container.findElement(By.xpath("//span[@class='MuiTouchRipple-root']/parent::button[@title='Open']")).text.trim();
    if (text.isEmpty) return List<String>.empty();
    return text.split(', ');
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_container]);

  void clear() {
    if (values.isNotEmpty && !(values.length == 1 && values.elementAt(0) == 'All')) {
      var automation = Automation();
      Automation.driver.findElement(By.xpath("$xpath//span[@class='MuiTouchRipple-root']/parent::button[@title='Open']")).click();
      automation.waitUntilVisibleByXpath("//div[contains(@class, 'MuiAutocomplete-paper')]//ul");
      sleep(Duration(milliseconds: 500));
      for (var value in values) {
        var target = automation.waitUntilVisibleByXpath(
            "//div[contains(@class,'MuiAutocomplete-paper')]//ul/li[text()='$value' and contains(@data-focus,'')]");
        target.click();
        automation.waitUntilNotVisibleByXpath(
            "//div[contains(@class,'MuiAutocomplete-paper')]//ul/li[text()='$value' and contains(@data-focus,'')]");
        sleep(Duration(milliseconds: 500));
      }
      Automation.driver.keyboard.sendKeys(Keyboard.escape);
      automation.waitUntilNotVisibleByXpath("//div[contains(@class, 'MuiAutocomplete-paper')]//ul");
    }
  }

  Iterable<String> get availableOptions {
    var automation = Automation();
    automation.clickOnXpath("$xpath//button[contains(@class,'MuiIconButton-root') and @aria-label='Open']");
    automation.waitUntilVisibleByXpath("//div[contains(@class,'MuiAutocomplete-paper')]//ul");
    sleep(Duration(milliseconds: 500));
    var itemsNumber =
        Automation.driver.findElements(By.xpath("//div[contains(@class,'MuiAutocomplete-paper')]//ul/li")).length;
    var result = List<String>.empty(growable: true);
    for (var i = 1; i <= itemsNumber; i++) {
      result.add(Automation.driver.findElement(By.xpath("//div[contains(@class, 'MuiAutocomplete-paper')]//ul/li[$i]")).text);
    }
    Automation.driver.keyboard.sendKeys(Keyboard.escape);
    automation.waitUntilNotVisibleByXpath("//div[contains(@class, 'MuiAutocomplete-paper')]//ul");
    return result;
  }
}

class MuiAutocomplete {
  final String xpath;
  final WebElement _input;
  final bool doubleLineItems;

  MuiAutocomplete._(this.xpath, this._input, this.doubleLineItems);

  factory MuiAutocomplete(String xpath, {bool doubleLineItems = false}) {
    var automation = Automation();
    automation.waitUntilVisibleByXpath('$xpath//input');
    var input = Automation.driver.findElement(By.xpath('$xpath//input'));
    return MuiAutocomplete._(xpath, input, doubleLineItems);
  }

  void typePartOfValue(String part) {
    _input.sendKeys(part);
    sleep(Duration(seconds: 2));
  }

  set labelsValue (String? value){
    if (value != null) {
      _input.click;
      sleep(Duration(milliseconds: 500));
      _input.sendKeys(value);
      sleep(Duration(milliseconds: 500));
    }
  }

  set valueWithoutSuggestion(String? value) {
    clear();
    if (value != null) {
      _input.click;
      sleep(Duration(milliseconds: 500));
      _input.sendKeys(value);
      sleep(Duration(milliseconds: 500));
      Automation.driver.keyboard.sendKeys(Keyboard.escape);
      sleep(Duration(milliseconds: 200));
    }
  }

  set valueWithSuggestion(String? value) {
    clearClientAccount();
    if (value != null) {
      _input.click();
      sleep(Duration(milliseconds: 500));
      _input.sendKeys(value);
      sleep(Duration(milliseconds: 500));
      var automation = Automation();
      if (doubleLineItems) {
        automation.waitUntilAvailableInDomBy(
            By.xpath("//div[@class='MuiAutocomplete-popper']//ul/li//*[text()[1]='$value']"));
      } else {
        automation
            .waitUntilAvailableInDomBy(By.xpath("//div[@class='MuiAutocomplete-popper']//ul/li[text()[1]='$value']"));
      }
      String optionXpath;
      if (doubleLineItems) {
        optionXpath = "//div[@class='MuiAutocomplete-popper']//ul/li//*[text()[1]='$value']";
      } else {
        optionXpath = "//div[@class='MuiAutocomplete-popper']//ul/li[text()[1]='$value']";
      }
      automation.scrollIntoView(Automation.driver.findElementByXpath(optionXpath));
      Automation.driver.findElementByXpath(optionXpath).click();
      automation.waitUntilElementHasParticularValue(By.xpath('$xpath//input'), value);
    }
  }

  String get value {
    return Automation.driver.findElement(By.xpath(xpath)).cssProperties['value']!;
  }

  String get valueClearClientAccount {
    return Automation.driver.findElement(By.xpath('$xpath//input')).properties['value']!;
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_input]);

  void clear() {
    if (value != '') {
      _input.click();
      sleep(Duration(milliseconds: 100));
      var button = Automation.driver.findElement(By.xpath("$xpath//button[@title='Clear']"));
      button.click();
      var automation = Automation();
      automation.waitUntilElementHasParticularValue(By.xpath('$xpath//input'), '');
      //Trying to fix a failing test here which shows on screenshot that the dropdown remains opened after clearing
      Automation.driver.keyboard.sendKeys(Keyboard.escape);
    }
  }
  void clearClientAccount() {
    if (valueClearClientAccount != '') {
      _input.click();
      sleep(Duration(milliseconds: 100));
      var button = Automation.driver.findElement(By.xpath("$xpath//button[@title='Clear']"));
      button.click();
      var automation = Automation();
      automation.waitUntilElementHasParticularValue(By.xpath('$xpath//input'), '');
      //Trying to fix a failing test here which shows on screenshot that the dropdown remains opened after clearing
      Automation.driver.keyboard.sendKeys(Keyboard.escape);
    }
  }

  Iterable<String> get availableOptions {
    _input.click();
    var automation = Automation();
    var attempt =
    Automation.Try(() => automation.waitUntilVisibleByXpath("//div[@class='MuiAutocomplete-popper']//ul"));
    if (attempt is Failure) {
      return Iterable<String>.empty();
    }
    sleep(Duration(milliseconds: 500));
    var optionsNumber =
        Automation.driver.findElements(By.xpath("//div[@class='MuiAutocomplete-popper']//ul/li")).length;
    var result = <String>[];
    for (var i = 1; i <= optionsNumber; i++) {
      result.add(Automation.driver.findElement(By.xpath("//div[@class='MuiAutocomplete-popper']//ul/li[$i]")).text);
    }
    Automation.driver.keyboard.sendKeys(Keyboard.escape);
    automation.waitUntilNotVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
    return result;
  }

  bool suggestedOptionsShown() => Automation().isVisibleByXpath("//div[@class='MuiAutocomplete-popper']//ul");

  Iterable<String> get suggestedOptions {
    var automation = Automation();
    automation.waitUntilVisibleByXpath("//div[@class='MuiAutocomplete-popper']//ul");
    sleep(Duration(milliseconds: 500));
    var optionsNumber =
        Automation.driver.findElements(By.xpath("//div[@class='MuiAutocomplete-popper']//ul/li")).length;
    var result = <String>[];
    for (var i = 1; i <= optionsNumber; i++) {
      result.add(Automation.driver.findElement(By.xpath("//div[@class='MuiAutocomplete-popper']//ul/li[$i]")).text);
    }
    Automation.driver.keyboard.sendKeys(Keyboard.escape);
    automation.waitUntilNotVisibleByXpath("//ul[contains(@class, 'MuiMenu-list')]");
    return result;
  }

  bool isOptionVerified(String option) {
    return Automation().isVisibleByXpath("//div[@class='MuiAutocomplete-popper']//ul/li[.='$option']/*[name()='svg']");
  }
}

class MuiInput {
  final String xpath;
  final WebElement _container;
  final WebElement _input;

  MuiInput._(this.xpath, this._container, this._input);

  factory MuiInput(String xpath) {
    var container = Automation.driver.findElement(By.xpath(xpath));
    var input = container.findElement(By.xpath('.//input'));
    return MuiInput._(xpath, container, input);
  }

  void _focus() {
    _container.click();
    var automation = Automation();
    automation.waitUntilVisibleByXpath("$xpath//div[contains(@class, 'Mui-focused')]");
  }

  set value(String? value) {
    _focus();
    clearSlowly();
    if (value != null) {
      typeNaturally(value);
    }
  }

  String? get value {
    return _input.properties['value'];
  }

  void clear() {
    _focus();
    clearSlowly();
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_input]);

  void sendKeys(String keys) => _input.sendKeys(keys);

  void typeNaturally(String value) {
    _focus();
    value.split('').forEach((symbol) {
      _input.sendKeys(symbol);
      sleep(Duration(milliseconds: 150));
    });
    sleep(Duration(milliseconds: 500));
  }

  void clearSlowly() {
    _focus();
    var length = value!.length;
    for (var i = 0; i < length; i++) {
      _input.sendKeys(String.fromCharCode($bs));
      _input.sendKeys(String.fromCharCode($bs));
      sleep(Duration(milliseconds: 70));
    }
    _focus();
    var lengthAfterClear = value!.length;
    if (lengthAfterClear != 0) {
      for (var i = 0; i < lengthAfterClear; i++) {
        _input.sendKeys(String.fromCharCode($bs));
        _input.sendKeys(String.fromCharCode($bs));
        sleep(Duration(milliseconds: 70));
      }
    }
    sleep(Duration(milliseconds: 100));
  }
}

class DateInput {
  final By selector;
  final WebElement _input;

  DateInput._(this.selector, this._input);

  factory DateInput(By selector) {
    var input = Automation.driver.findElement(selector);
    return DateInput._(selector, input);
  }

  set value(DateTime? value) {
    var format = standardDateFormat;
    clearDate();
    if (value != null) {
      typeNaturally(format.format(value));
    }
  }

  DateTime? get value {
    var rawValue = _input.properties['value'];
    return rawValue == null || rawValue.isEmpty ? null : dateInputValueGetFormat.parse(rawValue);
  }

  void scrollToView() => Automation.driver.execute('arguments[0].scrollIntoView(true);', [_input]);

  void sendKeys(String keys) => _input.sendKeys(keys);

  void typeNaturally(String value) {
    value.split('').forEach((symbol) {
      _input.sendKeys(symbol);
      sleep(Duration(milliseconds: 300));
    });
    sleep(Duration(milliseconds: 500));
  }

  void clearDate() {
    for (var i = 1; i <= 8; i++) {
      _input.sendKeys(String.fromCharCode($del));
    }
    for (var i = 1; i <= 8; i++) {
      _input.sendKeys(String.fromCharCode($bs));
    }
    sleep(Duration(milliseconds: 100));
  }

  WebElement get webElement => _input;
}
