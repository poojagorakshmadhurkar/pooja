*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collection
Library  Datadriver


*** Variables ***

@{itemData1}  WIP_194  500             #warehouse value is 270   #20 inward note
@{itemData2}  WIP_193  300              #warehouse value is 170     #10 outward note
${keyword1_count}    0
${keyword2_count}    0                                                             #issue :When two inward note created than approve button not visible error comes
                                     #always ensure 1st option is doing outward and second inward
*** Test Cases ***
Manually Reconcile                 #Reconcile with WIP
    login
    select site  testing_site_automation
    sleep  3
    open warehouse
    ${stockvalue1}  item onhand stock(WIP)  ${itemData1}[0]
    sleep  2
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
    [Arguments]    ${currentstockvalue}    ${reconcilevalue}  ${itemname}
    ${result1}          Set Variable    ${currentstockvalue} - ${reconcilevalue}
    ${outwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${outwardtab}
    open outward tr note  1
    wait until element is visible  //span[text() = "${itemname}"]
    ${quantityS}  Get Text  //span[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${notevalue}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${outwardvalue}    ${notevalue}
#    ${fetchoutwardADJNote}  Get Text  //button[normalize-space()='Disapprove Request']/../span[2]
#    return from keyword  ${fetchoutwardADJNote}
    reload page
    sleep  5
    Increment Keyword 1 Count
    sleep  3
    open warehouse
    sleep  2
    ${finalwarehousevalue}  item onhand stock(WIP)  ${itemname}
    ${warehouseresult}          Evaluate    ${currentstockvalue} - ${notevalue}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}


Test keyword 2    #inward note will be created
    [Arguments]    ${currentstockvalue}    ${reconcilevalue}  ${itemname}
    ${result1}          Set Variable    ${reconcilevalue} - ${currentstockvalue}
    ${inwardvalue}  Evaluate  eval("${result1}")
    Click  ${inventorybutton}
    Click  ${Transactiobutton}
    Click  ${inwardtab}
    open inward tr note  1
    wait until element is visible  //a[text() = "${itemname}"]
    ${quantityS}  Get Text  //a[text() = "${itemname}"]/ancestor::tr/td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${notevalue}  Convert To Integer  ${Quantity_number}
    Should Be Equal As Numbers    ${inwardvalue}    ${notevalue}
    reload page
    sleep  5
    Increment Keyword 2 Count
    sleep  3
    open warehouse
    sleep  2
    ${finalwarehousevalue}  item onhand stock(WIP)  ${itemname}
    ${warehouseresult}          Evaluate    ${currentstockvalue} + ${notevalue}
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
    click  //div[@id="item__tabs-tab-2"]
    click  (//span[@role='button'])[3]
    Wait Until Element Is Visible  //input[@placeholder="Search Item Details"]  timeout=10s
    press keys  //input[@placeholder="Search Item Details"]  CTRL+A  BACKSPACE
    input  //input[@placeholder="Search Item Details"]  ${itemName}
    click  ${searchicon}
    sleep  2
    Wait Until Page Contains Element  //div[@id = "item__tabs-panel-2"]//span[text() = "${itemName}"]    timeout=10s

Click Inward Approval Button
    [Documentation]    Clicks the inward approval button
    Scroll Element Into View    //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//button[@aria-label="Approve"]
    Wait Until Element Is Visible    //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//button[@aria-label="Approve"]
    Capture Page Screenshot    # Optional for debugging
    Click Element    //div[@id="item__tabs-panel-credit"]//tbody//tr[2]//td[11]//button[@aria-label="Approve"]

Click Outward Approval Button
    [Documentation]    Clicks the outward approval button
    Scroll Element Into View    //div[@id="item__tabs-panel-debit"]//tbody//tr[2]//td[10]//button[@aria-label="Approve"]
    Wait Until Element Is Visible    //div[@id="item__tabs-panel-debit"]//tbody//tr[2]//td[10]//button[@aria-label="Approve"]
    Capture Page Screenshot    # Optional for debugging
    Click Element    //div[@id="item__tabs-panel-debit"]//tbody//tr[2]//td[10]//button[@aria-label="Approve"]

Click Approval Button Based on Keyword Count
    [Documentation]    Clicks the approval button based on the count of Keyword 1 and Keyword 2
    Run Keyword If    ${keyword1_count} == 2  Click Outward Approval Button
    Run Keyword If    ${keyword2_count} == 2  Click Inward Approval Button

Increment Keyword 1 Count
    ${keyword1_count}=    Evaluate    ${keyword1_count} + 1
    Set Test Variable    ${keyword1_count}
    Run Keyword If    ${keyword1_count} == 1  Click Outward Approval Button

Increment Keyword 2 Count
    ${keyword2_count}=    Evaluate    ${keyword2_count} + 1
    Set Test Variable    ${keyword2_count}
    Run Keyword If    ${keyword2_count} == 1  Click Inward Approval Button