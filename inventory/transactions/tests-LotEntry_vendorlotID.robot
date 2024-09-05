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
${SLIDER_HANDLE_XPATH}    //div[@class='slider-handle']
${SLIDER_CONTAINER_XPATH}  //div[@class='slider-container']



*** Test Cases ***
#Validation lot case with IQC
Lot inward request for for Vendorlot id with manufacturing date
    Set Selenium Speed    0.1s
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
    ${lot_id}  ${vendor_lot_id}  ${formatted_expiry_date} =    Set Ith Item In Lot Case With Vendor LotID    0    ${itemData1}[0]    ${itemData1}[1]
    click  ${newRequest}
    open transactions page
    sleep  2
    open inward tr note  1
    #click on expand button of lot
    click  (//span[@class='MuiButtonBase-root MuiCheckbox-root MuiCheckbox-colorDefault PrivateSwitchBase-root MuiCheckbox-root MuiCheckbox-colorDefault MuiCheckbox-root MuiCheckbox-colorDefault css-1rlbz42'])[1]
    wait until element is visible  //a[text()="${itemData1}[0]"]/../../../../../../../../../../td[text()="${itemData1}[1] kg"]
    wait until element is visible  //span[text()="${lot_id}"]/../../td[text()="${vendor_lot_id}"]/..//td[text()="${formatted_expiry_date}"][1]
    sleep  1
    click  //button[@class='MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeLarge css-1w8s6so']
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
    #get text from lotit and compare that value with send value
    ${lotidvalue}  Search LotID name in warehouse  ${itemData1}[0]  ${lot_id}
    wait until element is visible    //td[text()="${lot_id}"]/../..//td[text()="${vendor_lot_id}"]/../..//td[text()="${formatted_expiry_date}"][3]
    sleep  1
    Should Be Equal As Integers    ${itemData1}[1]   ${lotidvalue}









*** Keywords ***

item LOTforCase current stock
    [Arguments]  ${itemName}
    search name in warehouse  ${itemName}
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
    sleep  2
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

Close Overlay If Present
    [Arguments]    ${overlay_xpath}
    Run Keyword If    Element Is Visible    ${overlay_xpath}    Click Element    ${overlay_xpath}