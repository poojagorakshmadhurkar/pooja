*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections


*** Variables ***
@{itemData1}  RackTest1123  10  5
@{itemData2}  Am_testing1  50  67
@{itemData3}  CAP  100  90
@{itemData4}  C1-22-404  11   12
@{itemData5}  Compound1  13  14
@{itemData6}  Compound2  15  16

*** Test Cases ***
#Validation lot case with IQC
Lot inward request for 1 item single lot
    login
    select site  testing_site_automation_l_o_tcase4
    open warehouse
    ${save}  item LOTforCase current stock  ${itemData1}[0]
    sleep  2
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test_Employee04
#   ${randomGrn}=  generate random string  5-10  [NUMBERS]
#   input  ${grnNumber}  ${randomGrn}
    select partner  Pooja01
    input  ${invoiceNumber}  inv1001
    set ith item in Lot case  0  ${itemData1}[0]  ${itemData1}[1]
    sleep  2
    wait until element is visible  //input[@id="credit__details__0__0__bundle"]
    #FetchGRN Value
    ${LOTIDitem1}=  Get Element Attribute And Log  0  ${itemData1}[0]
    click  ${submit}
    click  ${newRequest}
    open transactions page
    sleep  2
    inward tr status no method 2  IQC Pending  1
    # Validation for if IQc enble than without it should not get approved
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]//button[@aria-label="Approve"]
    wait until page contains    perform IQC first
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    sleep  2
    click  ${inwardEdit}
    rejection reason  BUBBLES  ${itemData1}[0]  ${itemData1}[2]
    click  //button[@id="credit__rejections__submit"]
    i should see text on page  Transaction Edited SuccesFully
    open transactions page
    wait until element is visible  ${newInwardNote}
    sleep  2
    inward tr status no method 2  Pending  1
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1
    reload page
    sleep  2
    open warehouse
    sleep  2
    ${finalvalue1}  item LOTforCase current stock  ${itemData1}[0]
    ${increment1}  Set Variable  ${itemData1}[1]-${itemData1}[2]
    ${increment_main1}  Evaluate  eval("${increment1}")
    ${value1}  Set Variable  ${save}+${increment_main1}
    ${finalstock1}  Evaluate  eval("${value1}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    #get text from lotit and compare that value with send value
    ${lotidvalue}  Search LotID name in warehouse  ${itemData1}[0]  ${LOTIDitem1}
    Should Be Equal As Integers    ${increment_main1}   ${lotidvalue}






*** Keywords ***

item LOTforCase current stock
    [Arguments]  ${itemName}
    search name in warehouse  ${itemName}
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //div[@id="item__tabs-panel-1"]//tr[2]//span[text()="${itemName}"]/../../../../../../../../../td[4]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}

Get Element Attribute And Log
    [Arguments]  ${j}  ${itemName}
    ${value} =    SeleniumLibrary.Get Element Attribute  //span[text()="${itemData1}[0]"]/../../../../../div[3]//input[@id="credit__details__${j}__0__bundle"]    value
    Log    ${value}
    [Return]    ${value}


search name in warehouse
    [Arguments]  ${itemName}
    Wait Until Element Is Visible  (//span[@role='button'])[1]  timeout=30s

    click element  (//span[@role='button'])[1]
    sleep  2
    press keys  ${RMitemName}  CTRL+A  BACKSPACE
    input  ${RMitemName}  ${itemName}
    press keys  ${RMitemName}  ENTER
    sleep  1
    wait until page contains element  //span[text() = "${itemName}"]  20

Search LotID name in warehouse
    [Arguments]  ${itemName}  ${lotid}
    search name in warehouse  ${itemName}
    scroll element into view  //span[text() = "${itemName}"]
    click  //div[@id="item__tabs-panel-1"]//tr[2]//span[text()="${itemName}"]/../../../../../../../../../td[1]//button
    click  (//span[@role='button'])[3]
    Wait Until Element Is Visible  //input[@placeholder="Search Lot Id"]  timeout=10s
    press keys  //input[@placeholder="Search Lot Id"]  CTRL+A  BACKSPACE
    input  //input[@placeholder="Search Lot Id"]  ${lotid}
    press keys  //input[@placeholder="Search Lot Id"]  ENTER
    WAIT UNTIL PAGE CONTAINS  ${lotid}
    ${quantityS}  Get Text  (//div[@id="item__tabs-panel-1"]//tr[3]//tr[2]//td[text()="${lotid}"])/../td[2]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    [Return]  ${integer_value}




