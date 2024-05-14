*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime


*** Variables ***

@{itemData1}  ItemRM-10  11  11



*** Test Cases ***
Outward to customer
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomation3rackcase
#validation to check item is present in warehouse if not then inward it

    Search and Check Item Quantity with iqc with rackcase  ${itemData1}[0]  ${itemData1}[2]  Test_Employee04  Pooja30

    sleep  1
    open warehouse
    ${save1}  item current stock for Rackcase  ${itemData1}[0]

    sleep  2
    open trasactions page
    Wait Until Element Is Visible  ${outwardTab}
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Pooja30
    sleep  1
    Wait Until Element Is Visible    //span[normalize-space()='Invoice Number *']    10
    Input Text  //input[@id='debit__form__invoice_number']  inv1001
    input Text  //input[@id='debit__form__truck_number']  Truck123
    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]

    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    outward approve number  1
    ${1st rack}=  racking  1
    ${Racktext}=    Get Text    //span[text()="${itemData1}[0]"]/../../../../div[3]//li/span[1]
    sleep  1
    ${quantity}=    Get Text    //span[text()="${itemData1}[0]"]/../../../../div[3]//span[text()="${Racktext}"]/../span[2]


    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    sleep  1
    inward tr status no method 2  Approved  1
    reload page
    sleep  2
    open warehouse
##validation of warehouse
#    ${finalvalue1}  item current stock for Rackcase  ${edititemData1}[0]
#    ${value1}  Set Variable  ${save1}-${edititemData1}[1]
#    ${finalstock1}  Evaluate  eval("${value1}")
#    ${finalvalue2}  item current stock for Rackcase  ${edititemData2}[0]
#    ${value2}  Set Variable  ${save2}-${edititemData2}[1]
#    ${finalstock2}  Evaluate  eval("${value2}")
#    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
#    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}




*** Keywords ***

#Inward when item zero with IQC rackcase
#    [Arguments]   ${itemname}   ${itemquantity}  ${inspector}  ${patner}
#    open transactions page
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  ${inspector}
#    select partner  ${patner}
#    input  ${invoiceNumber}  inv1001
#    set ith item in inward  0  ${itemname}  ${itemquantity}
#    click  ${inwardSubmit}
#    click  ${newRequest}
#    open transactions page
#    sleep  2
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
#    sleep  2
#    ${1st rack}=  racking  1
#    racking approval  0  ${1st rack}
#    ${Racktext}=    Get Text    //span[text()="${itemName}"]/../../../../div[3]//li/span[1]
#    ${quantity}=    Get Text    //div[text()="Test Item"]/../../..//span[text()="${Racktext}"]/../span[2]
#
#    click  ${approveRequest}
#    i should see text on page  MRN approved SuccesFully
#    sleep  1
#    inward tr status no method 2  Approved  1
#    RETURN  ${Racktext}  ${quantity}
#
#
#Search and Check Item Quantity with iqc with rackcase
#    [Arguments]  ${itemName}  ${itemquantity}  ${inspector}  ${patner}
#    open warehouse
#    ${item1_found}    Search For Item    ${itemName}
#    Run Keyword If    not ${item1_found}    Inward when item zero with IQC rackcase  ${itemName}  ${itemquantity}  ${inspector}  ${patner}
#    sleep  1
#
#item current stock for Rackcase
#    [Arguments]  ${itemName}
#    search name in warehouse  ${itemName}
#    scroll element into view  //span[text() = "${itemName}"]
#    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[4]
#    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
#    ${integer_value}  Convert To Integer  ${Quantity_number}
##    click  //button[@aria-label="Expand row"]
##    sleep  1
##    click  (//span[@role="button"])[3]
##    click  //input[@placeholder="Search Rack Id"]
##    Wait Until Element Is Visible  //input[@placeholder="Search Rack Id"]  timeout=10s
##    press keys  //input[@placeholder="Search Rack Id"]  CTRL+A  BACKSPACE
##    input  //input[@placeholder="Search Rack Id"]  ${Racktext}
##    press keys  //input[@placeholder="Search Rack Id"]  ENTER
##    wait until element is visible  ${quantity}
#    RETURN  ${integer_value}