*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot

*** Keywords ***

open warehouse
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    wait until page contains  Live Inventory

item onhand stock(Rawmaterial)
    [Arguments]  ${itemName}
    search rawmaterailname in warehouse  ${itemName}
    sleep  2
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}




search rawmaterailname in warehouse
    [Arguments]  ${itemName}
    click  ${warehouseFilter}
    sleep  3
    press keys  ${warehouseFilterItemName}  CTRL+A  BACKSPACE
    input  ${warehouseFilterItemName}  ${itemName}
    press keys  ${searchicon}  ENTER
    sleep  2
    wait until page contains element  //span[text() = "${itemName}"]  10




open outward tr note
    [Arguments]  ${i}
    click  //div[@id='item__tabs-panel-debit']//tr[${i}+1]//td[2]
    sleep  1

open inward tr note
    [Arguments]  ${i}
    click  //div[@id='item__tabs-panel-credit']//tr[${i}+1]//td[2]
    sleep  1

Form row
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    click  //form//tbody//tr[${i}]//td[1]//input[@type = "search"]/../../span[2]
    input  //form//tbody//tr[${i}]//td[1]//input[@type = "search"]  ${recievedName}
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  10
   # click  //*[text() = "${recievedName}"]
    press keys   //form//tbody//tr[${i}]//td[1]//input[@type = "search"]  ENTER
    sleep  1
    Element Should Be Enabled  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]
    input  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]  ${recievedQuantity}
    press keys  //form//tbody//tr[${i}]//td[2]//input[@type = "text"]  TAB
    sleep  1


inward approve number
    [Arguments]  ${i}
    click  (//div[@id='item__tabs-panel-credit']//button[@aria-label= "Approve"][1])[${i}]
    sleep  1

outward approve number
    [Arguments]  ${i}
    click  (//div[@id='item__tabs-panel-debit']//button[@aria-label= "Approve"][1])[${i}]
    sleep  1

