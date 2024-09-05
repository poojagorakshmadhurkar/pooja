from robot.api.deco import keyword
from SeleniumLibrary import SeleniumLibrary
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from robot.libraries.BuiltIn import BuiltIn

@keyword
def drag_and_drop(source_xpath, target_xpath):
    # Get the active Selenium driver instance from SeleniumLibrary
    selenium_lib = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = selenium_lib.driver

    # Locate the source and target elements by their XPath using the new method
    source_element = driver.find_element(By.XPATH, source_xpath)
    target_element = driver.find_element(By.XPATH, target_xpath)

    # Create an instance of ActionChains
    actions = ActionChains(driver)

    # Perform the drag-and-drop operation
    actions.drag_and_drop(source_element, target_element).perform()
