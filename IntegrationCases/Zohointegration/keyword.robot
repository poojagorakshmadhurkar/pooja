*** Settings ***
#Library  SeleniumLibrary
#Resource  ../../variables.robot
#Resource  ../../masters/production/items/keywords.robot
#Resource  ../../masters/production/items/variables.robot
Resource  ../../keywords.robot
Library  Browser
Resource    ../../inventory/transactions/keywords.robot




*** Keywords ***

verify it should be added in Zoho
    [Arguments]  ${itemCodeName}
    Fill Text      //input[@id='app-quick-search-field']  ${itemCodeName}
    browser.press keys  //input[@id='app-quick-search-field']  Enter
    Wait For Elements State      ${itemCodeName}  timeout=20s

set ith item in PO zoho
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    browser.press keys  //input[@id="purchase_order_${i}_sku"]/../../span[2]  Control+A
    browser.press keys  //input[@id="purchase_order_${i}_sku"]/../../span[2]    Backspace
    input   //input[@id="purchase_order_${i}_sku"]   ${recievedName}
    browser.press keys  //input[@id="purchase_order_${i}_sku"]  Enter
    browser.press keys    //input[@id="purchase_order_${i}_quantity"]  Control+A
    browser.press keys    //input[@id="purchase_order_${i}_quantity"]   Backspace
    input    //input[@id="purchase_order_${i}_quantity"]    ${recievedQuantity}

open Po tracker page
    click  ${planningDropdown}
    Wait For Elements State       //a[@id='purchase_orders']   visible  timeout=30s
    click  //ul[@id='menu-list-grow']//a[@id="purchase_orders"]
    Wait For Elements State    //h5[normalize-space()='purchase orders']   visible  timeout=120s
    sleep  1
    click    //h5[normalize-space()='purchase orders']

search Sonumber in POListpage for validation
    [Arguments]  ${POordernumber}
    Wait For Elements State     //h5[normalize-space()='purchase orders']  visible   timeout=60s
    click  //h5[normalize-space()='purchase orders']
    Wait For Elements State        css=.ant-spin-spinning   hidden   timeout=60s
    Wait For Elements State      svg[id='purchase_order_PO Number_search']  visible   timeout=30s
    click   svg[id='purchase_order_PO Number_search']
    click   //input[@placeholder='Search PO Number']
    browser.press keys  //input[@placeholder='Search PO Number']  Control+A
    browser.press keys  //input[@placeholder='Search PO Number']   Backspace
    input  //input[@placeholder='Search PO Number']  ${POordernumber}
    browser.press keys  //input[@placeholder='Search PO Number']  Enter