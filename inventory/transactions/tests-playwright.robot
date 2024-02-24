*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime


*** Variables ***
@{itemData1}  ItemRM-11  49  100
@{itemData2}  ItemRM-10  49  100

#@{edititemData1}  RM0001  56
#@{edititemData2}  RM0002  32
#@{edititemData3}  RM0003  65

*** Test Cases ***
IQC allok non rack case
    login
    select site  testing_automation_site2
    Search and Check Item Quantity with iqc  ${itemData1}[0]  ${itemData1}[2]  Test Customer-01  Vendor1113
    Search and Check Item Quantity with iqc  ${itemData2}[0]  ${itemData2}[2]  Test Customer-01  Vendor1113

    sleep  2
    open warehouse
    ${save1}  item current stock  ${itemData1}[0]
    ${save2}  item current stock  ${itemData1}[0]
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
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}


#





*** Keywords ***

Inward when item zero with IQC
    [Arguments]   ${itemName}   ${itemquantity}  ${inspector}  ${partner}
    open transactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  ${inspector}
    select partner  ${partner}
    set ith item in inward  0  ${itemName}  ${itemquantity}
    click  ${submit}
    sleep  1
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    inward tr status no method 2  IQC Pending  1
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




*** Keywords ***
Search and Check Item Quantity with IQC
    [Arguments]  ${itemName}  ${itemquantity}  ${inspector}  ${partner}
    Open Warehouse
    ${item_found}  Search For Item  ${itemName}
    Run Keyword If  not ${item_found}
    ...  Inward when item zero with IQC  ${itemName}  ${itemquantity}  ${inspector}  ${partner}
    ...  ELSE IF  "${item_found}" == "True"
    ...  Check Item Stock and Decide Inward  ${itemName}  ${itemquantity}  ${inspector}  ${partner}

Check Item Stock and Decide Inward
    [Arguments]  ${itemName}  ${itemquantity}  ${inspector}  ${partner}
    ${stock}  Fetch Item Stock  ${itemName}
    Run Keyword If  "${stock}" == "" or "${stock}" == "None"
    ...  Inward when item zero with IQC  ${itemName}  ${itemquantity}  ${inspector}  ${partner}
    ...  ELSE IF  ${stock} == 0
    ...  Log  Item '${itemName}' found in the warehouse with quantity ${stock}. No need for inward process.
    ...  ELSE
    ...  Log  Item '${itemName}' found in the warehouse with quantity ${stock}. No need for inward process.

Fetch Item Stock
    [Arguments]  ${itemName}
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[3]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${stock}  Run Keyword If  "${Quantity_number}" != ""
    ...  Convert To Integer  ${Quantity_number}
    RETURN  ${stock}
