*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData1}  ItemRM-10  49  10
@{itemData2}  ItemRM-11  60  10
@{itemData3}  ItemRM-12  510
#@{edititemData1}  RM0001  56
#@{edititemData2}  RM0002  32
#@{edititemData3}  RM0003  65

*** Test Cases ***
IQC allok non rack case
    login
    select site  testing_automation_site2
    Search and Check Item Quantity with iqc  ${itemData1}[0]  ${itemData1}[1]  Test Customer-01  Vendor1113
    Search and Check Item Quantity with iqc  ${itemData2}[0]  ${itemData2}[1]  Test Customer-01  Vendor1113
    Search and Check Item Quantity with iqc  ${itemData3}[0]  ${itemData3}[1]  Test Customer-01  Vendor1113
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
#    reload page
    sleep  2
    inward tr status no method 2  IQC Pending  1
# Validation for if IQc enble than without it should not get approved
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]//button[@aria-label="Approve"]
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
    ${finalvalue1}  item current stock  ${itemData1}[0]
    ${value1}  Set Variable  ${save1}+${itemData1}[1]
    ${finalstock1}  Evaluate  eval("${value1}")
    ${finalvalue2}  item current stock  ${itemData2}[0]
    ${value2}  Set Variable  ${save2}+${itemData2}[1]
    ${finalstock2}  Evaluate  eval("${value2}")
    ${finalvalue3}  item current stock  ${itemData3}[0]
    ${value3}  Set Variable  ${save3}+${itemData3}[1]
    ${finalstock3}  Evaluate  eval("${value3}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}
    Should Be Equal As Integers    ${finalvalue3}    ${finalstock3}

#





