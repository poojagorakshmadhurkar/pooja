*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library  BuiltIn
Library  ActionChains


*** Variables ***

@{itemData1}  RawmaterialA  3000             #warehouse value is 700   #20 outward note
@{itemData2}  RawmaterialB  200              #warehouse value is 850     #20 inward note
${keyword1_count}    0
${keyword2_count}    0                           #issue :When two inward note created than approve button not visible error comes
                                     #always ensure 1st option is doing outward and second inward
*** Test Cases ***
Manually Reconcile                 #Reconcile with Rawmaterial
    login
    select site  testing_site_automation
    sleep  3
    open warehouse
    ${stockvalue1}  item onhand stock(Rawmaterial)  ${itemData1}[0]
    sleep  2
    ${stockvalue2}  item onhand stock(Rawmaterial)  ${itemData2}[0]
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
#    Test Keyword 1  ${stockvalue1}  ${itemData1}[1]  ${itemData1}[0]
#    Test Keyword 2  ${stockvalue2}  ${itemData2}[1]  ${itemData2}[0]
#    Click Approval Button Based on Keyword Count




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
    reload page
    wait until page contains  Transactions
    sleep  5
    Increment Keyword 1 Count
    sleep  3
    open warehouse
    sleep  2
    ${finalwarehousevalue}    item onhand stock(Rawmaterial)    ${itemname}
    ${warehouseresult}    Evaluate    ${currentstockvalue} - ${notevalue}
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
    wait until page contains  Transactions
    sleep  5
    Increment Keyword 2 Count
    sleep  3
    open warehouse
    sleep  1
    ${finalwarehousevalue}    item onhand stock(Rawmaterial)    ${itemname}
    ${warehouseresult}    Evaluate    ${currentstockvalue} + ${notevalue}
    Should Be Equal As Numbers    ${warehouseresult}    ${finalwarehousevalue}


Increment Keyword 1 Count
    ${keyword1_count}=    Evaluate    ${keyword1_count} + 1
    Set Test Variable    ${keyword1_count}
    Run Keyword If    ${keyword1_count} == 1  Click Outward Approval Button

Increment Keyword 2 Count
    ${keyword2_count}=    Evaluate    ${keyword2_count} + 1
    Set Test Variable    ${keyword2_count}
    Run Keyword If    ${keyword2_count} == 1  Click Inward Approval Button


Camparison
    [Arguments]    ${stockvalue}    ${reconcilevalue}  ${itemname}
    Run Keyword If    ${stockvalue} > ${reconcilevalue}  Test keyword 1  ${stockvalue}    ${reconcilevalue}  ${itemname}
...  ELSE IF  ${stockvalue} < ${reconcilevalue}  Test keyword 2  ${stockvalue}    ${reconcilevalue}  ${itemname}
...  ELSE IF  ${stockvalue} == ${reconcilevalue}  Log    This is a log statement for equal
    Log    This is a log statement




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
