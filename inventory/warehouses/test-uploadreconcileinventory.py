
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from selenium.webdriver.remote import webelement
from selenium.webdriver.support.wait import WebDriverWait

# Test Case For Upload of Reconcile of Inventory Warehouse
#Using item Test Am (rawmaterial inventory value is 200)
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)
driver = webdriver.Chrome(executable_path='C:\\Users\\user\\Downloads\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe', options=chrome_options)
time.sleep(5)
driver.implicitly_wait(10)
driver.get('https://manuf.app/signin')
driver.maximize_window()
driver.find_element(By.XPATH,"//input[@name = 'email']").send_keys("admin@smart.com")
driver.find_element(By.XPATH,"//input[@name = 'password']").send_keys("Manufapp2023")
driver.find_element(By.XPATH,"//button[text() = 'Sign In']").click()
driver.find_element(By.XPATH,"//button[text()='Inventory']").click()
time.sleep(2)
driver.find_element(By.XPATH,"//a[text()='Warehouses']").click()

driver.refresh()
time.sleep(3)
driver.find_element(By.XPATH,"(//*[@data-testid='MoreVertIcon']/..)").click()
driver.find_element(By.XPATH,"//div[text() = 'Reconcile Inventory']").click()
time.sleep(5)

upload_button = driver.find_element(By.XPATH, " //button[@id='undefined__upload_file_btn']")
driver.execute_script("arguments[0].scrollIntoView();", upload_button)
upload_button.click()
time.sleep(5)
Fileinput=driver.find_element(By.XPATH,"//input[@accept='.csv']")
time.sleep(5)
Fileinput.send_keys("C:\\Users\\user\\Documents\\sample\\Reconcile_18-Jan-2024_19_43.csv")
submit_button = WebDriverWait(driver, 10).until(
        EC.element_to_be_clickable((By.XPATH, "//button[text()='Submit File']"))
    )
submit_button.click()
driver.quit()


