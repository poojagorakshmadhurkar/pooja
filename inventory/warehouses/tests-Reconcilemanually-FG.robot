*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collection
Library  Datadriver


*** Variables ***

@{itemData1}  1223  220             #warehouse value is 240   #20 outward note
@{itemData2}  1221  200              #warehouse value is 150      #50 inward note
                                     #issue :When two inward note created than approve button not visible error comes

*** Test Cases ***
Manually Reconcile                 #Reconcile with WIP
    login
    select site  testing_site_automation
    sleep  3
    open warehouse
    ${item1value}  item onhand stock(WIP)  ${itemData1}[0]
    ${item2value}  item onhand stock(WIP)  ${itemData2}[0]
    #${b}  Convert To Integer  ${b}
    Log    ${item1value}
    Log    ${item2value}
    sleep  2
    click  ${filter}
    click  ${reconcileinventory}
    click  ${formbutton}

    Form row  1  ${itemData1}[0]  ${itemData1}[1]
    Form row  2  ${itemData2}[0]  ${itemData2}[1]
    click  //button[contains(@type,'submit')]
    i should see text on page  Entry Saved SuccesFully
    camparison  ${item1value}  ${itemData1}[1]  ${itemData1}[0]
    camparison  ${item2value}  ${itemData2}[1]  ${itemData2}[0]



*** Keywords ***

Test keyword 1     #Outward Note will be created
    [Arguments]    ${K}    ${Name1}  ${name}
    Log    Running Test keyword 1 with A: ${K} and itemData1: ${Name1}
    Log   itemname: ${name}
    ${first_number}    Set Variable  ${K}
    ${second_number}   Set Variable  ${Name1}
    ${result1}          Evaluate    ${first_number} - ${second_number}
    Log                Result of subtraction in Test keyword 1: ${result1}
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${outwardtab}
    open outward tr note  1
    wait until element is visible  //span[text() = "${name}"]
    ${quantityS}  Get Text  //span[text() = "${name}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${result1}    ${integer_value}
    reload page
    sleep  2
    Click  (//div[@id = "item__tabs-panel-debit"]//button[@aria-label='Approve'])[1]
    open warehouse
    ${item1newvalue}  item onhand stock(WIP)  ${name}
    ${finalwarehousevalue}          Evaluate    ${first_number} - ${integer_value}
    Should Be Equal As Numbers    ${item1newvalue}    ${finalwarehousevalue}



Test keyword 2    #inward note will be created
    [Arguments]    ${P}    ${Name2}  ${name}
    Log    Running Test keyword 2 with A: ${P} and itemData1: ${Name2}
    Log   itemname: ${name}
    ${first_number}    Set Variable  ${P}
    ${second_number}   Set Variable  ${Name2}
    ${result2}          Evaluate    ${second_number} - ${first_number}
    Log                Result of subtraction in Test keyword 2: ${result2}
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${inwardtab}
    open inward tr note  1
    wait until element is visible  //a[text() = "${name}"]
    ${quantityS}  Get Text  //a[text() = "${name}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    reload page
    sleep  2
    Click  (//div[@id = "item__tabs-panel-credit"]//button[@aria-label='Approve'])[1]
    open warehouse
    ${item2newvalue}  item onhand stock(WIP)  ${name}
    ${finalwarehousevalue}          Evaluate    ${first_number} + ${integer_value}
    Should Be Equal As Numbers    ${item2newvalue}    ${finalwarehousevalue}


Camparison
    [Arguments]    ${A}    ${b}  ${recievedname}
    Run Keyword If    ${A} > ${b}  Test keyword 1  ${A}  ${b}  ${recievedname}
...  ELSE IF  ${A} < ${b}  Test keyword 2  ${A}  ${b}  ${recievedname}
...  ELSE IF  ${A} == ${b}  Log    This is a log statement for equal
    Log    This is a log statement

item onhand stock(WIP)
    [Arguments]  ${itemName}
    search WIPname in warehouse  ${itemName}
    scroll element into view  //div[@id="item__tabs-panel-3"]//span[text()="${itemName}"]
    ${quantityS}  Get Text  //div[@id="item__tabs-panel-3"]//span[text()="${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}



search WIPname in warehouse
    [Arguments]  ${itemName}
    click  //div[text()="FG"]
    click  (//span[@role='button'])[3]
    press keys  ${warehouseFilterItemName}  CTRL+A  BACKSPACE
    input  ${warehouseFilterItemName}  ${itemName}
    click  ${searchicon}
    sleep  2
    Wait Until Page Contains Element  //div[@id="item__tabs-panel-3"]//span[text()="${itemName}"]    timeout=10s
