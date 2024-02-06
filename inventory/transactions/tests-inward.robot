*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData1}  RMItem-7  44
@{itemData2}  RMItem-6  20
@{itemData3}  RMItem-5  22
@{edititemData1}  RM0001  100
@{edititemData2}  RM0002  8
@{edititemData3}  RM0003  35

*** Test Cases ***
inward request with rack off
    login
    select site  testing_site_automation
    Search and Check Item Quantity  ${edititemData1}[0]  ${edititemData1}[1]  Test_Employee07  Vendor1113
    Search and Check Item Quantity  ${edititemData2}[0]  ${edititemData2}[1]  Test_Employee07  Vendor1113
    Search and Check Item Quantity  ${edititemData3}[0]  ${edititemData3}[1]  Test_Employee07  Vendor1113
    open warehouse
    ${A}  item current stock  ${itemData1}[0]
    ${B}  item current stock  ${itemData2}[0]
    ${C}  item current stock  ${itemData3}[0]
    ${save1}  item current stock  ${edititemData1}[0]
    ${save2}  item current stock  ${edititemData2}[0]
    ${save3}  item current stock  ${edititemData3}[0]
    sleep  2
    open transactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test_Employee07
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    press keys  ${grnNumber}  CTRL+BACKSPACE
#    input  ${grnNumber}  ${randomGrn}
    select partner  Vendor1113
    input  ${invoiceNumber}  inv1001
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in inward  1  ${itemData2}[0]  ${itemData2}[1]
    set ith item in inward  2  ${itemData3}[0]  ${itemData3}[1]
    click  ${submit}
    click  ${newRequest}
    open transactions page
    sleep  2
    inward tr status no method 2  Pending  1
#    wait until page contains  ${newInwardNote}
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${edit}
    edit inward entry  0  ${edititemData1}[0]  ${edititemData1}[1]
    edit inward entry  1  ${edititemData2}[0]  ${edititemData2}[1]
    edit inward entry  2  ${edititemData3}[0]  ${edititemData3}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  1
    inward tr status no method 2  Approved  1
    reload page
    sleep  1
    open warehouse
    ${finalvalue1}  item current stock  ${edititemData1}[0]
    ${finalstock1}  Evaluate  eval("${save1}+${edititemData1}[1]")
    ${finalvalue2}  item current stock  ${edititemData2}[0]
    ${finalstock2}  Evaluate  eval("${save2}+${edititemData2}[1]")
    ${finalvalue3}  item current stock  ${edititemData3}[0]
    ${finalstock3}  Evaluate  eval("${save3}+${edititemData3}[1]")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}
    Should Be Equal As Integers    ${finalvalue3}    ${finalstock3}




