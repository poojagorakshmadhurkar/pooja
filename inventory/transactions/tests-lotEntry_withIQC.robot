*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RackTest1123  10  40
@{itemData2}  Am_testing1  50  67
@{itemData3}  CAP  100  90
@{itemData4}  C1-22-404  11   12
@{itemData5}  Compound1  13  14
@{itemData6}  Compound2  15  16

*** Test Cases ***
#Validation lot case with IQC
Lot inward request for 1 item single lot
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomationlotcase4
    open warehouse
    sleep  2
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
    click  (//div[@id='item__tabs-panel-credit']//button//*[name()='svg'][@id="transaction_credit_approve"])[1]
    wait until page contains    perform IQC first
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    sleep  2
    click  ${inwardEdit}
    click  ${allOk}
    wait until element is visible  //span[text() = "No Rejections"]
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
    ${finalstock1}  Evaluate  eval("${save}+${itemData1}[1]")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    sleep  1
    #get text from lotit and compare that value with send value
    ${lotidvalue}  Search LotID name in warehouse  ${itemData1}[0]  ${LOTIDitem1}
    Should Be Equal As Integers    ${itemData1}[1]   ${lotidvalue}







#Lot inward request for 2 item individual lot
#Lot inward request for 2 item single lot
#    login
#    select site  testing_site_automation_l_o_tcase4
#    open trasactions page
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Test_Employee04
##    ${randomGrn}=  generate random string  5-10  [NUMBERS]
##    input  ${grnNumber}  ${randomGrn}
#    select partner  Pooja01
#    input  ${invoiceNumber}  inv1001
#    set ith item in Lot case  0  ${itemData1}[0]  ${itemData1}[1]
#    set ith item in Lot case  1  ${itemData2}[0]  ${itemData2}[1]
#    click  ${submit}
#    click  ${newRequest}
#    open transactions page
#    sleep  2
#    inward tr status no method 2  IQC Pending  1
#    # Validation for if IQc enble than without it should not get approved
#    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]//button[@aria-label="Approve"]
#    wait until page contains    perform IQC first
#    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
#    click  ${qualityChecktab}
#    sleep  2
#    click  ${inwardEdit}
#    click  ${allOk}
#    wait until element is visible  //span[text() = "No Rejections"]
#    i should see text on page  Transaction Edited SuccesFully
#    open transactions page
#    wait until element is visible  ${newInwardNote}
#    sleep  2
#    inward tr status no method 2  Pending  1
#    inward approve number  1
#    i should see text on page  MRN approved SuccesFully
#    sleep  2
#    inward tr status no method 2  Approved  1
##
#Lot inward request for 1 item multiple lot
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv10411
#    set ith item in multiple Lot case  0  1  ${itemData4}
#    click  ${submit}
#    click  ${newRequest}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully
#
#Lot inward request for 2 item multiple lot
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv0812
#    set ith item in multiple Lot case  0  1  ${itemData5}
#    set ith item in multiple Lot case  1  2  3  ${itemData6}
#    click  ${submit}
#    click  ${newRequest}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully
#
#Lot inward with rejection
#    login
#    select warehouse name from dropdown  ${smartFactory}  3
#    open trasactions page
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv1001
#    set ith item in Lot case  0  ${itemData1}
#    click  ${submit}
#    click  ${addDetailsToThisRequest}
#    click  ${edit}
#    rejection reason  0  Bubbles  1
#    click  ${submit}
#    i should see text on page  Transaction Edited SuccesFully
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully



*** Keywords ***

item LOTforCase current stock
    [Arguments]  ${itemName}
    search name in warehouse  ${itemName}
    sleep  1
    scroll element into view  //span[text() = "${itemName}"]
    ${quantityS}  Get Text  //div[@id="live_inventory_item__tabs-panel-1"]//tr[2]//span[text()="${itemName}"]/../../../../../../../../../td[4]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}

Get Element Attribute And Log
    [Arguments]  ${j}  ${itemName}
    ${value} =    SeleniumLibrary.Get Element Attribute  //span[text()="${itemData1}[0]"]/../../../../../div[3]//input[@id="credit__details__${j}__0__bundle"]    value
    Log    ${value}
    RETURN  ${value}


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
    click  //div[@id="live_inventory_item__tabs-panel-1"]//tr[2]//span[text()="${itemName}"]/../../../../../../../../../td[1]//button
    click  (//span[@role='button'])[3]
    Wait Until Element Is Visible  //input[@placeholder="Search Lot Id"]  timeout=10s
    press keys  //input[@placeholder="Search Lot Id"]  CTRL+A  BACKSPACE
    input  //input[@placeholder="Search Lot Id"]  ${lotid}
    press keys  //input[@placeholder="Search Lot Id"]  ENTER
    WAIT UNTIL PAGE CONTAINS  ${lotid}
    ${quantityS}  Get Text  //div[@id="live_inventory_item__tabs-panel-1"]//tr[3]//tr[2]//td[1][text()="${lotid}"]/../td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}