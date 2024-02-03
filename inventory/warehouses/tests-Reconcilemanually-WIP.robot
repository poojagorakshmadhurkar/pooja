*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collection
Library  Datadriver


*** Variables ***

@{itemData1}  WIP_194  260             #warehouse value is 240   #20 inward note
@{itemData2}  WIP_193  180              #warehouse value is 190     #10 outward note
                                     #issue :When two inward note created than approve button not visible error comes

*** Test Cases ***
Manually Reconcile                 #Reconcile with WIP
    login
    select site  testing_site_automation
    sleep  3
    open warehouse
    ${stockvalue1}  item onhand stock(WIP)  ${itemData1}[0]
    ${stockvalue2}  item onhand stock(WIP)  ${itemData2}[0]
    #${b}  Convert To Integer  ${b}
    sleep  2
    click  ${filter}
    click  ${reconcileinventory}
    click  ${formbutton}

    Form row  1  ${itemData1}[0]  ${itemData1}[1]
    Form row  2  ${itemData2}[0]  ${itemData2}[1]
    click  //button[contains(@type,'submit')]
    i should see text on page  Entry Saved SuccesFully
    camparison  ${stockvalue1}  ${itemData1}[1]  ${itemData1}[0]
    camparison  ${stockvalue2}  ${itemData2}[1]  ${itemData2}[0]



*** Keywords ***

Test keyword 1     #Outward Note will be created
    [Arguments]    ${stockvalue}    ${itemvalue}  ${itemname}
    ${result1}          Set Variable    ${stockvalue} - ${itemvalue}
    ${outwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${outwardtab}
    open outward tr note  1
    wait until element is visible  //span[text() = "${itemname}"]
    ${quantityS}  Get Text  //span[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${result1}    ${integer_value}
#    ${fetchoutwardADJNote}  Get Text  //button[normalize-space()='Disapprove Request']/../span[2]
#    return from keyword  ${fetchoutwardADJNote}
    reload page
    sleep  2
    Click  (//div[@id = "item__tabs-panel-debit"]//button[@aria-label='Approve'])[1]
    open warehouse
    ${finalwarehousevalue}  item onhand stock(Rawmaterial)  ${itemname}
    ${warehouseresult}          Evaluate    ${stockvalue} - ${integer_value}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}



Test keyword 2    #inward note will be created
    [Arguments]    ${stockvalue}    ${itemvalue}  ${itemname}
    ${result1}          Set Variable    ${stockvalue} - ${itemvalue}
    ${outwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${inwardtab}
    open inward tr note  1
    wait until element is visible  //a[text() = "${itemname}"]
    ${quantityS}  Get Text  //a[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    reload page
    sleep  2
    Click  //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//button[@aria-label="Approve"]
    open warehouse
    ${finalwarehousevalue}  item onhand stock(Rawmaterial)  ${itemname}
    ${warehouseresult}          Evaluate    ${stockvalue} - ${integer_value}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}



Camparison
    [Arguments]    ${stockvalue}    ${reconcilevalue}  ${itemname}
    Run Keyword If    ${stockvalue} > ${reconcilevalue}  Test keyword 1  ${stockvalue}    ${reconcilevalue}  ${itemname}
...  ELSE IF  ${stockvalue} < ${reconcilevalue}  Test keyword 2  ${stockvalue}    ${reconcilevalue}  ${itemname}
...  ELSE IF  ${stockvalue} == ${reconcilevalue}  Log    This is a log statement for equal
    Log    This is a log statement

item onhand stock(WIP)
    [Arguments]  ${itemName}
    search WIPname in warehouse  ${itemName}
    scroll element into view  //div[@id = "item__tabs-panel-2"]//span[text() = "${itemName}"]
    ${quantityS}  Get Text  //div[@id = "item__tabs-panel-2"]//span[text() = "${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}



search WIPname in warehouse
    [Arguments]  ${itemName}
    click  //div[text()="WIP"]
    click  (//span[@role='button'])[3]
    press keys  ${warehouseFilterItemName}  CTRL+A  BACKSPACE
    input  ${warehouseFilterItemName}  ${itemName}
    click  ${searchicon}
    sleep  2
    Wait Until Page Contains Element  //div[@id = "item__tabs-panel-2"]//span[text() = "${itemName}"]    timeout=10s

