*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData1}  RM00010  49  10
@{itemData2}  RM00012  60  10
@{itemData3}  RM00013  510  10
#@{edititemData1}  RM0001  56
#@{edititemData2}  RM0002  32
#@{edititemData3}  RM0003  65

*** Test Cases ***
IQC with rejection rack case
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomation3rackcase
    Search and Check Item Quantity with iqc with rackcase  ${itemData1}[0]  ${itemData1}[1]  Test Customer-01  Pooja30
    Search and Check Item Quantity with iqc with rackcase  ${itemData2}[0]  ${itemData2}[1]  Test Customer-01  Pooja30
    Search and Check Item Quantity with iqc with rackcase  ${itemData3}[0]  ${itemData3}[1]  Test Customer-01  Pooja30
    open warehouse
    ${save1}  item current stock for Rackcase  ${itemData1}[0]
    ${save2}  item current stock for Rackcase  ${itemData2}[0]
    ${save3}  item current stock for Rackcase  ${itemData3}[0]
    sleep  2
    open transactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test_Employee04
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    press keys  ${grnNumber}  CTRL+BACKSPACE
#    input  ${grnNumber}  ${randomGrn}
    select partner  Pooja30
    input  ${invoiceNumber}  inv1001
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in inward  1  ${itemData2}[0]  ${itemData2}[1]
    set ith item in inward  2  ${itemData3}[0]  ${itemData3}[1]
    click  ${inwardSubmit}
    click  ${newRequest}
    open transactions page
    sleep  2
    inward tr status no method 2  IQC Pending  1
#    wait until page contains  ${newInwardNote}
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    sleep  2
    click  ${inwardEdit}
    rejection reason  BUBBLES  ${itemData1}[0]  ${itemData1}[2]
    rejection reason  UNEVEN-SURFACE  ${itemData2}[0]  ${itemData2}[2]
    rejection reason  Chuck Nut  ${itemData3}[0]  ${itemData3}[2]
    click  ${inwardRejSubmit}
    wait until element is visible  //span[text() = "Rejected"]
    i should see text on page  Transaction Edited SuccesFully
    open transactions page
    wait until element is visible  ${newInwardNote}
    sleep  2
    inward tr status no method 2  Pending  1
    inward approve number  1
    sleep  2
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
    ${finalvalue1}  item current stock for Rackcase  ${itemData1}[0]
    ${increment1}  Set Variable  ${itemData1}[1]-${itemData1}[2]
    ${increment_main1}  Evaluate  eval("${increment1}")
    ${value1}  Set Variable  ${save1}+${increment_main1}
    ${finalstock1}  Evaluate  eval("${value1}")
    ${finalvalue2}  item current stock for Rackcase  ${itemData2}[0]
    ${increment2}  Set Variable  ${itemData2}[1]-${itemData2}[2]
    ${increment_main2}  Evaluate  eval("${increment2}")
    ${value2}  Set Variable  ${save2}+${increment_main2}
    ${finalstock2}  Evaluate  eval("${value2}")
    ${finalvalue3}  item current stock for Rackcase  ${itemData3}[0]
    ${increment3}  Set Variable  ${itemData3}[1]-${itemData3}[2]
    ${increment_main3}  Evaluate  eval("${increment3}")
    ${value3}  Set Variable  ${save3}+${increment_main3}
    ${finalstock3}  Evaluate  eval("${value3}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}
    Should Be Equal As Integers    ${finalvalue3}    ${finalstock3}