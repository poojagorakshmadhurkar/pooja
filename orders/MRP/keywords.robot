*** Settings ***
#Library  SeleniumLibrary
Resource  ./variables.robot
Library  String
Library  Collections
#Library  SeleniumLibrary
Resource  ../../keywords.robot
#Resource  ../../variables.robot
#Resource  ./variables.robot
Library  DateTime
Resource  ../../inventory/warehouses/keywords.robot
Library    Browser

*** Keywords ***

open order tracker page for MRP
    browser.click  ${planningDropdown}
    sleep   1
    browser.click  //a[@id='m_r_p']


Checkbox selection based on salesorder number
    [Arguments]  ${salesordernumber}
    click  //a[text()="${salesordernumber}"]/../../../../../../../../../../td[1]
   sleep  1


search name in warehouse Fg
    [Arguments]  ${itemName}
    click  (//div[@id='live_inventory_item__tabs-tab-3'])[1]
    Wait For Elements State        css=.ant-spin-spinning   hidden   timeout=60s
    Wait For Elements State      (//*[name()='svg'][@id='live_inventory_Item Details_search'])[1]  visible  timeout=60s
    click  (//*[name()='svg'][@id='live_inventory_Item Details_search'])[1]
    click  (//input[@placeholder='Search Item Details'])[1]
    Wait For Elements State     (//input[@placeholder='Search Item Details'])[1]  visible   timeout=60s
    browser.press Keys    (//input[@placeholder='Search Item Details'])[1]    Control+A
    browser.Press Keys    (//input[@placeholder='Search Item Details'])[1]    Backspace
    input  (//input[@placeholder='Search Item Details'])[1]  ${itemName}
    browser.press keys  (//input[@placeholder='Search Item Details'])[1]  Enter
    Wait For Elements State    (//span[text() ="${itemName}"])[1]  visible   timeout=60s



item current stock for Fg
    [Arguments]  ${itemName}
    search name in warehouse Fg  ${itemName}
    scroll to element  (//span[text() ="${itemName}"])[1]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[5]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}


Set ith item in mrp
    [Arguments]  ${itemName}    ${Quantity}
    sleep  1
    click   (//a[text()="${itemName}"])[2]/../../../../../../../../../../td[3]//input[@type="number"]
    Press Keys       (//a[text()="${itemName}"])[2]/../../../../../../../../../../td[3]//input[@type="number"]  Control+A
    Press Keys       (//a[text()="${itemName}"])[2]/../../../../../../../../../../td[3]//input[@type="number"]  Backspace
    sleep  1
    Fill Text      (//a[text()="${itemName}"])[2]/../../../../../../../../../../td[3]//input[@type="number"]     ${Quantity}
    Press Keys    (//a[text()="${itemName}"])[2]/../../../../../../../../../../td[3]//input[@type="number"]   Enter



Date Entry of mrp
    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    ${today1}=    Evaluate    datetime.datetime.now().strftime('%d-%m-%Y')
#    Log To Console    Current Date: ${today1}
#    BuiltIn.Sleep    1
    browser.click  //th[text()='Delivery date']/../../../../../div[2]//input[@placeholder="Select date"]
    browser.click  //a[text()="Today"]