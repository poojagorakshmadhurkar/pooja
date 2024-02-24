*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime


*** Variables ***
@{itemData1}  RM0002  20  5000
@{itemData2}  RM0003  30  5000
@{edititemData1}  ItemRM-10  11  5000
@{edititemData2}  ItemRM-11  20  5000
@{inwarditem1}  RM0002  500
@{inwarditem2}  RM0003  500

*** Test Cases ***
Outward to customer
    login
    select site  testingsite_automation3_rackcase
#validation to check item is present in warehouse if not then inward it
    Search and Check Item Quantity with iqc with rackcase  ${edititemData1}[0]  ${edititemData1}[2]  Testcustomer11  Pooja30
    Search and Check Item Quantity with iqc with rackcase  ${itemData1}[0]  ${itemData1}[2]  Testcustomer11  Pooja30
    Search and Check Item Quantity with iqc with rackcase  ${edititemData2}[0]  ${edititemData2}[2]  Testcustomer11  Pooja30
    Search and Check Item Quantity with iqc with rackcase  ${itemData2}[0]  ${itemData2}[2]  Testcustomer11  Pooja30
    sleep  1
    open warehouse
    ${save1}  item current stock for Rackcase  ${edititemData1}[0]
    ${save2}  item current stock for Rackcase  ${edititemData2}[0]
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
    set ith item in outward  1  ${itemData2}[0]  ${itemData2}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
    click  ${edit}
    edit ith item in outward  0  ${edititemData1}[0]  ${edititemData1}[1]
    edit ith item in outward  1  ${edititemData2}[0]  ${edititemData2}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    click  ${outwardtab}
    outward approve number  1
    ${1st rack}=  racking  1
    ${2nd rack}=  racking  2

    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    sleep  1
    inward tr status no method 2  Approved  1
    reload page
    sleep  2
    open warehouse
#validation of warehouse
    ${finalvalue1}  item current stock for Rackcase  ${edititemData1}[0]
    ${value1}  Set Variable  ${save1}-${edititemData1}[1]
    ${finalstock1}  Evaluate  eval("${value1}")
    ${finalvalue2}  item current stock for Rackcase  ${edititemData2}[0]
    ${value2}  Set Variable  ${save2}-${edititemData2}[1]
    ${finalstock2}  Evaluate  eval("${value2}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}

