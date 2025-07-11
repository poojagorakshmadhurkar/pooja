*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Resource   ../../././Access_Control/Keyword.robot
Resource   ../../././orders/PurchaseOrder/keyword.robot
Resource   ../../././orders/PurchaseOrder/variable.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Variable1.robot
*** Variables ***
${my_text}    Sales Orders
@{customername1}    Test01
@{itemData11}    Fgitem1  100  50

*** Test Cases ***
TC_01_VERIFY_OEE_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${OEE}   30s
    sleep   0.05s
    close Browser
TC_02_VERIFY_DASHBOARD_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    Set Selenium Speed  1s
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()
    Call Method  ${options}  add_argument  incognito
    Create WebDriver  Chrome  options=${options}
    Go To  ${URL}
    reload page
    maximize browser window
    sleep   1s
    wait until page contains element    ${MOBILE OR EMAIL}  30s
    wait until element is visible   ${MOBILE OR EMAIL}  30s
    Input Text   ${MOBILE OR EMAIL}   nitesh_@gmail.com     #abhijit@gmail.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Input Text   ${PASSWORD}   9377668854   #8605544332    #${Pass}     #8824427172   #4652049559
    click button    ${SIGNIN}
    sleep   1s
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${DASHBOARD}   30s
    sleep   0.05s
    close Browser
TC_03_VERIFY_PRODUCTION_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_PRODUCTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${PRODUCTION}   30s
    sleep   0.05s
    close Browser
TC_04_VERIFY_PRODUCTION_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_PRODUCTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${PRODUCTION_D}   30s
    sleep   0.05s
    close Browser
TC_05_VERIFY_DOWNTIME_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_DOWNTIME_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${DOWNTIME}   30s
    sleep   0.05s
    close Browser
TC_06_VERIFY_DOWNTIME_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_DOWNTIME_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${DOWNTIME}   30s
    sleep   0.05s
    close Browser
TC_07_VERIFY_QUALITY_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_QUALITY_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${QUALITY}   30s
    sleep   0.05s
    close Browser
TC_08_VERIFY_QUALITY_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_QUALITY_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${QUALITY}   30s
    sleep   0.05s
    close Browser
TC_09_VERIFY_POWER_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_POWER_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${POWER}   30s
    sleep   0.05s
    close Browser
TC_10_VERIFY_POWER_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_POWER_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${POWER}   30s
    sleep   0.05s
    close Browser
TC_11_VERIFY_SCRAP_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_SCRAP_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${SCRAP}   30s
    sleep   0.05s
    close Browser
TC_12_VERIFY_SCRAP_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_SCRAP_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${SCRAP}   30s
    sleep   0.05s
    close Browser
TC_13_VERIFY_INVENTORY_VIEW_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_OEE_CHECKBOX}
    click   ${CLICK_INVENTORY_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${INVENTORY}   30s
    sleep   0.05s
    close Browser
TC_14_VERIFY_INVENTORY_VIEW_ACCESS_DISABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DASHBOARD_+_BTN}
    sleep   0.5s
    click   ${CLICK_INVENTORY_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${DASHBOARD}
    set selenium speed    0.07s
#   View access check
    element should not be visible   ${INVENTORY}   30s
    sleep   0.05s
    close Browser




