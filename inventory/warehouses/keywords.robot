*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Resource  ../../inventory/transactions/keywords.robot
Library  Collections

*** Keywords ***

#open warehouse
#    click  ${inventoryDropdown}
#    click  ${inventoryWarehouses}
#    wait until page contains  Live Inventory

item onhand stock(Rawmaterial)
    [Arguments]  ${itemName}
    search rawmaterailname in warehouse  ${itemName}
    sleep  2
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}




search rawmaterailname in warehouse
    [Arguments]  ${itemName}
    click  ${warehouseFilter}
    sleep  3
    press keys  ${warehouseFilterItemName}  CTRL+A  BACKSPACE
    input  ${warehouseFilterItemName}  ${itemName}
    press keys  ${searchicon}  ENTER
    sleep  2
    wait until page contains element  //span[text() = "${itemName}"]  10




#open outward tr note
#    [Arguments]  ${i}
#    click  //div[@id='item__tabs-panel-debit']//tr[${i}+1]//td[2]
#    sleep  1
#
#open inward tr note
#    [Arguments]  ${i}
#    click  //div[@id='item__tabs-panel-credit']//tr[${i}+1]//td[2]
#    sleep  1

Form row
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    sleep  1
    Click  //form//tbody//tr[${i}]//td[1]//input[@type = "search"]/../../span[1]
    input  //form//tbody//tr[${i}]//td[1]//input[@type = "search"]  ${recievedName}
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
   # click  //*[text() = "${recievedName}"]
    press keys   //form//tbody//tr[${i}]//td[1]//input[@type = "search"]  ENTER
    sleep  1
    Element Should Be Enabled  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]

    ${quantity_value}=  Get Value  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]

    ${quantity_length}=  Evaluate  len($quantity_value)
    FOR    ${index}    IN RANGE    ${quantity_length}
        press keys  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]  BACKSPACE    # ASCII code for Backspace
    END
    input  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]  ${recievedQuantity}
    press keys  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]  TAB
    sleep  1
    RETURN  ${quantity_value}


#inward approve number
#    [Arguments]  ${i}
#    click  (//div[@id='item__tabs-panel-credit']//button[@aria-label= "Approve"][1])[${i}]
#    sleep  1
#
#outward approve number
#    [Arguments]  ${i}
#    click  (//div[@id='item__tabs-panel-debit']//button[@aria-label= "Approve"][1])[${i}]
#    sleep  1

Click Inward Approval Button
    [Documentation]    Clicks the inward approval button
    Scroll Element Into View    //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//*[name()='svg'][@id='transaction_credit_approve']
    Wait Until Element Is Visible    //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//*[name()='svg'][@id='transaction_credit_approve']
    Capture Page Screenshot    # Optional for debugging
    Click Element    //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//*[name()='svg'][@id='transaction_credit_approve']

Click Outward Approval Button
    [Documentation]    Clicks the outward approval button
    Scroll Element Into View    //div[@id="item__tabs-panel-debit"]//tbody//tr[2]//td[10]//*[name()='svg'][@id="transaction_debit_approve"]
    Wait Until Element Is Visible    //div[@id="item__tabs-panel-debit"]//tbody//tr[2]//td[10]//*[name()='svg'][@id="transaction_debit_approve"]
    Capture Page Screenshot    # Optional for debugging
    Click Element    //div[@id="item__tabs-panel-debit"]//tbody//tr[2]//td[10]//*[name()='svg'][@id="transaction_debit_approve"]


Increment Keyword 1 Count
    [Arguments]    ${keyword1_count}
    ${keyword1_count}=    Evaluate    ${keyword1_count} + 1
    Set Test Variable    ${keyword1_count}
    Run Keyword If    ${keyword1_count} == 1  Click Outward Approval Button

Increment Keyword 2 Count
    [Arguments]    ${keyword2_count}
    ${keyword2_count}=    Evaluate    ${keyword2_count} + 1
    Set Test Variable    ${keyword2_count}
    Run Keyword If    ${keyword2_count} == 1  Click Inward Approval Button

item onhand stock(WIP)
    [Arguments]  ${itemName}
    search WIPname in warehouse  ${itemName}
    scroll element into view  //div[@id="live_inventory_item__tabs-panel-2"]//span[text()="${itemName}"]
    ${quantityS}  Get Text  //div[@id="live_inventory_item__tabs-panel-2"]//span[text()="${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}



search WIPname in warehouse
    [Arguments]  ${itemName}
    click  //div[@id="live_inventory_item__tabs-tab-2"]
    click  //div[@id="live_inventory_item__tabs-panel-2"]//*[@id="live_inventory_Item Details_search"]
    Wait Until Element Is Visible  //input[@placeholder="Search Item Details"]  timeout=10s
    press keys  //input[@placeholder="Search Item Details"]  CTRL+A  BACKSPACE
    input  //input[@placeholder="Search Item Details"]  ${itemName}
    click  ${searchicon}
    sleep  2
    Wait Until Page Contains Element  //span[text() = "${itemName}"]    timeout=10s


item onhand stock(Fg)
    [Arguments]  ${itemName}
    search fg in warehouse  ${itemName}
    sleep  2
    scroll element into view  //div[@id="live_inventory_item__tabs-panel-3"]//span[text()="${itemName}"]
    ${quantityS}  Get Text  //div[@id="live_inventory_item__tabs-panel-3"]//span[text()="${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}



search Fg in warehouse
    [Arguments]  ${itemName}
    click  //div[@id="live_inventory_item__tabs-tab-3"]
    sleep  1
    click  //div[@id="live_inventory_item__tabs-panel-3"]//*[@id="live_inventory_Item Details_search"]
    sleep  2
    Wait Until Page Contains Element    //input[@placeholder='Search Item Details']    10s
    press keys  ${warehouseFilterItemName}  CTRL+A  BACKSPACE
    input  ${warehouseFilterItemName}  ${itemName}
    press keys  ${searchicon}  ENTER
    sleep  2
    Wait Until Page Contains Element  //span[text()="${itemName}"]    timeout=10s
