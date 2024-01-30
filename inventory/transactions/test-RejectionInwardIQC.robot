*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime


*** Variables ***
@{itemData1}  RM-001-1  10  5             #Test Case:verify Inward Request IQc with some rejection entry and validated with its Warehouse Quantity is getting updated in rejected section also

*** Test Cases ***
inward request with rack off              #while running this IQC should be On
    login
    select site  employetes50
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    sleep  2
    wait until page contains  Live Inventory
    search name in warehouse  ${itemData1}[0]
    ${savedata1}  item current stock  ${itemData1}[0]
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test Customer-01
    ${randomGrn}=  generate random string  5-10  [NUMBERS]
    press keys  ${grnNumber}  CTRL+BACKSPACE
    input  ${grnNumber}  ${randomGrn}
    select partner  Vendor1113
    input  ${invoiceNumber}  inv1001
    input  ${trucknumber}  12344
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    sleep  2
    inward tr status no method 2  IQC Pending  1
    click  //tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    click  ${inwardEdit}
    rejection reason  0  BUBBLES  ${itemData1}[2]
    click  ${inwardRejSubmit}
    wait until element is visible  //span[text() = "Rejected"]
    i should see text on page  Transaction Edited SuccesFully
    open trasactions page
    wait until element is visible  ${newInwardNote}
    sleep  2
    inward tr status no method 2  Pending  1
    ${first_number}    Set Variable  ${itemData1}[1]            #10
    ${second_number}   Set Variable  ${itemData1}[2]            #5
    ${result}          Evaluate  ${first_number} - ${second_number}         #5
    Log                Result of subtraction: ${result}
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1
    ${first_number}    Set Variable  ${savedata1}
    ${second_number}   Set Variable  ${result}
    ${result1}  Evaluate  ${first_number} + ${second_number}
    Log                Result of Addition: ${result1}
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    sleep  2
    wait until page contains  Live Inventory
    search name in warehouse  ${itemData1}[0]
    ${savedata2}  item current stock  ${itemData1}[0]
    ${expected_result}   Set Variable    ${result1}
    ${actual_result}     Set Variable    ${savedata2}
    Should Be Equal As Numbers  ${actual_result}    ${expected_result}


