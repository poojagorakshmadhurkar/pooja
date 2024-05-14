*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library  DateTime


*** Variables ***

@{itemData1}  AAA-2010  50  2000
@{edititemData1}  AAA-2010  50


*** Test Cases ***
W2W transfer
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomation
    Search and Check Item Quantity  ${itemData1}[0]  ${itemData1}[2]  Test_Employee07  Vendor1113
    sleep  2
    open warehouse
    ${save1}  item current stock  ${itemData1}[0]
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Other Warehouse
    select recipient warehouse  Testing_AutomationSite2
    date entry
    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    click  //div[@id = "item__tabs-panel-debit"]//tr[2]//td[1]//a
    click  ${edit}
    edit ith item in outward  0  ${edititemData1}[0]  ${edititemData1}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    approve outward
    click  //div[@id="item__tabs-panel-debit"]//tbody/tr[2]//span[text()="Smart Admin"][1]

    # validation for after note approve with item name and its quantity
    wait until element is visible  //span[text()="${itemData1}[0]"]
    ${quantityS}  Get Text  (//span[text()="${itemData1}[0]"])/../../../../../../../../../../td[1]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    ${first_integer}    Set Variable  ${itemData1}[1]
    ${second_integer}   Set Variable  ${integer_value}
    Should Be Equal As Numbers    ${first_integer}    ${second_integer}

    open warehouse
    sleep  1
    ${finalvalue1}  item current stock  ${itemData1}[0]
    ${value1}  Set Variable  ${save1}-${itemData1}[1]
    ${finalstock1}  Evaluate  eval("${value1}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    #approve w2w transaction  HARIDWAR-
    sleep  2
    select site  testingautomationsite2
    reload page
    Search and Check Item Quantity  ${itemData1}[0]  ${itemData1}[2]  Test Customer-01  Vendor1113
    sleep  1
    open warehouse
    sleep  1
    ${save2}  item current stock  ${itemData1}[0]
    sleep  1
    open trasactions page
    click  ${inwardTab}
    sleep  2
    inward tr status no method 2  Pending  1
    #wait until element is visible  //span[text() = "Item View"]
    inward approve number  1
    select inspector while TIN  Test Customer-01
    click  ${approveButton}
    i should see text on page  IQC approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1
    sleep  1

    # validation for after note approve with item name and its quantity
    click  //div[@id="item__tabs-panel-credit"]//tbody/tr[2]//span[text()="Smart Admin"][1]
    wait until element is visible  //a[text()="${itemData1}[0]"]
    ${quantityS1}  Get Text  (//a[text()="${itemData1}[0]"])/../../../../../../../../../../td[1]
    ${Quantity_number1}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value1}  Convert To Integer  ${Quantity_number}
    ${first_integer1}    Set Variable  ${itemData1}[1]
    ${second_integer1}   Set Variable  ${integer_value1}
    Should Be Equal As Numbers    ${first_integer1}    ${second_integer1}
    Should Be Equal As Numbers    ${integer_value1}    ${integer_value}
    sleep  1

    open warehouse
    ${finalvalue2}  item current stock  ${itemData1}[0]
    ${value1}  Set Variable  ${save2}+${itemData1}[1]
    ${finalstock2}  Evaluate  eval("${value1}")
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}






















