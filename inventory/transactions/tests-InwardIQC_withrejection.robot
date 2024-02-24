*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData1}  RMItem-5  44  10
@{itemData2}  RMItem-7  20  11
@{itemData3}  RMItem-6  22  12


*** Test Cases ***
IQC with some rejection non rack case
    login
    select site  testing_automation_site2
    open warehouse
    ${save1}  item current stock  ${itemData1}[0]
    ${save2}  item current stock  ${itemData2}[0]
    ${save3}  item current stock  ${itemData3}[0]
    sleep  2
    open transactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test Customer-01
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    press keys  ${grnNumber}  CTRL+BACKSPACE
#    input  ${grnNumber}  ${randomGrn}
    select partner  Vendor1113
    input  ${invoiceNumber}  inv1001
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in inward  1  ${itemData2}[0]  ${itemData2}[1]
    set ith item in inward  2  ${itemData3}[0]  ${itemData3}[1]
    click  ${inwardSubmit}
    click  ${newRequest}
    open transactions page
    sleep  2
    inward tr status no method 2  IQC Pending  1
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    click  ${inwardEdit}
    rejection reason  BUBBLES  ${itemData1}[0]  ${itemData1}[2]
    rejection reason  test fail  ${itemData2}[0]  ${itemData2}[2]
    rejection reason  test fail  ${itemData3}[0]  ${itemData3}[2]
    click  ${inwardRejSubmit}
    wait until element is visible  //span[text() = "Rejected"]
    i should see text on page  Transaction Edited SuccesFully
    open transactions page
    wait until element is visible  ${newInwardNote}
    sleep  2
    inward tr status no method 2  Pending  1
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    inward tr status no method 2  Approved  1
    reload page
    sleep  2
    open warehouse
    ${finalvalue1}  item current stock  ${itemData1}[0]
    ${increment1}  Set Variable  ${itemData1}[1]-${itemData1}[2]
    ${increment_main1}  Evaluate  eval("${increment1}")
    ${value1}  Set Variable  ${save1}+${increment_main1}
    ${finalstock1}  Evaluate  eval("${value1}")
    ${finalvalue2}  item current stock  ${itemData2}[0]
    ${increment2}  Set Variable  ${itemData2}[1]-${itemData2}[2]
    ${increment_main2}  Evaluate  eval("${increment2}")
    ${value2}  Set Variable  ${save2}+${increment_main2}
    ${finalstock2}  Evaluate  eval("${value2}")
    ${finalvalue3}  item current stock  ${itemData3}[0]
    ${increment3}  Set Variable  ${itemData3}[1]-${itemData3}[2]
    ${increment_main3}  Evaluate  eval("${increment3}")
    ${value3}  Set Variable  ${save3}+${increment_main3}
    ${finalstock3}  Evaluate  eval("${value3}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}
    Should Be Equal As Integers    ${finalvalue3}    ${finalstock3}
