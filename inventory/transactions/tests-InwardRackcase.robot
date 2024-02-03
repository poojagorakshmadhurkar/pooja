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
inward request with rack on      #while running these testcase make sure IQC is Off in Rack Case
    login                        #So uing Haridware Unit for this
    select site  haridwar_unit
    open warehouse
    ${A}  item current stock for Rackcase  ${itemData1}[0]
    ${B}  item current stock for Rackcase  ${itemData2}[0]
    ${C}  item current stock for Rackcase  ${itemData3}[0]
    ${save1}  item current stock for Rackcase  ${edititemData1}[0]
    ${save2}  item current stock for Rackcase  ${edititemData2}[0]
    ${save3}  item current stock for Rackcase  ${edititemData3}[0]
    open transactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Employee 1
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    press keys  ${grnNumber}  CTRL+BACKSPACE
#    input  ${grnNumber}  ${randomGrn}
    select partner  Pooja12
    input  ${invoiceNumber}  inv1001
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in inward  1  ${itemData2}[0]  ${itemData2}[1]
    set ith item in inward  2  ${itemData3}[0]  ${itemData3}[1]
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    reload page
    sleep  2
#    inward tr status no method 2  Pending  1
#    Wait Until Page Contains Element  ${newInwardNote}  10
#    inward tr status no method 2  Pending  1
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
    ${1st rack}=  racking  1
    ${2nd rack}=  racking  2
    ${3rd rack}=  racking  3
    racking approval  0  ${1st rack}
    racking approval  1  ${2nd rack}
    racking approval  2  ${3rd rack}
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    sleep  1
    inward tr status no method 2  Approved  1
    reload page
    sleep  2
    open warehouse
    ${finalvalue1}  item current stock for Rackcase  ${edititemData1}[0]
    ${finalstock1}  Evaluate  eval("${save1}+${edititemData1}[1]")
    ${finalvalue2}  item current stock for Rackcase  ${edititemData2}[0]
    ${finalstock2}  Evaluate  eval("${save2}+${edititemData2}[1]")
    ${finalvalue3}  item current stock for Rackcase  ${edititemData3}[0]
    ${finalstock3}  Evaluate  eval("${save3}+${edititemData3}[1]")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}
    Should Be Equal As Integers    ${finalvalue3}    ${finalstock3}
