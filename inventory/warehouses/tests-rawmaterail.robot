*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collection
Library  Datadriver


*** Variables ***

@{itemData1}  RM_010  270             #warehouse value is 240   #170 inward note
@{itemData2}  152  270              #warehouse value is 240      #195 inward note
                                     #issue :When two inward note created than approve button not visible error comes

*** Test Cases ***
Manually Reconcile                 #Reconcile with Rawmaterial
    login
    select site  testing_site_automation
    sleep  3
    open warehouse
    ${item1value}  item onhand stock(Rawmaterial)  ${itemData1}[0]
    ${item2value}  item onhand stock(Rawmaterial)  ${itemData2}[0]
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
    camparison  ${item1value}  ${itemData1}[0]  ${itemData2}[0]
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
    ${item1newvalue}  item onhand stock(Rawmaterial)  ${name}
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
    Click  //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//button[@aria-label="Approve"]
    open warehouse
    ${item2newvalue}  item onhand stock(Rawmaterial)  ${name}
    ${finalwarehousevalue}          Evaluate    ${first_number} + ${integer_value}
    Should Be Equal As Numbers    ${item2newvalue}    ${finalwarehousevalue}


Camparison
    [Arguments]    ${A}    ${b}  ${recievedname} #camparison is of onhand stock in warehouse and reconcile value
    Run Keyword If    ${A} == ${b}  Test keyword 1  ${A}  ${b}  ${recievedname}
...  ELSE IF  ${A} < ${b}  Test keyword 2  ${A}  ${b}  ${recievedname}
...  ELSE IF  ${A} == ${b}  Log    This is a log statement for equal
    Log    This is a log statement
