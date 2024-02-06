*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime
*** Variables ***
@{itemData1}  RMitemA  20
@{itemData2}  RMitemB  30
@{edititemData1}  RawmaterialA  11
@{edititemData2}  RawmaterialB  32
@{inwarditem1}  RawmaterialA  500
@{inwarditem2}  RawmaterialB  500

*** Test Cases ***
Outward to customer
    login
    select site  testing_site_automation
#validation to check item is present in warehouse if not then inward it
    Search and Check Item Quantity  ${inwarditem1}[0]  ${inwarditem1}[1]  Test_Employee07  Vendor1113
    Search and Check Item Quantity  ${inwarditem2}[0]  ${inwarditem2}[1]  Test_Employee07  Vendor1113
    open warehouse
    ${save1}  item current stock  ${edititemData1}[0]
    ${save2}  item current stock  ${edititemData2}[0]
    sleep  2
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Cust-003
    date entry
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
    approve outward
    reload page
    sleep  2
    open warehouse
#validation of warehouse
    ${finalvalue1}  item current stock  ${edititemData1}[0]
    ${value1}  Set Variable  ${save1}-${edititemData1}[1]
    ${finalstock1}  Evaluate  eval("${value1}")
    ${finalvalue2}  item current stock  ${edititemData2}[0]
    ${value2}  Set Variable  ${save2}-${edititemData2}[1]
    ${finalstock2}  Evaluate  eval("${value2}")
    Should Be Equal As Integers    ${finalvalue1}    ${finalstock1}
    Should Be Equal As Integers    ${finalvalue2}    ${finalstock2}

#outward to JW Vendor
#    login
#    open trasactions page
#    click  ${outwardTab}
#    click  ${newOutwardNote}
#    select outward to  Jobwork Vendor
#    select jobwork vendor  Vendor15
#    date entry
#    set ith item in outward  0  ${itemData3}[0]  ${itemData3}[1]
#    click  ${submit}
#    click  ${newRequest}
#    approve outward
##    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
##    click  ${edit}
##    edit ith item in outward  1  ${edititemData2}[0]  ${edititemData2}[1]
##    click  ${submit}
##    i should see text on page  Transaction Edited SuccesFully
#
#outward to JW Customer
#    login
#    open trasactions page
#    click  ${outwardTab}
#    click  ${newOutwardNote}
#    select outward to  Jobwork Customer
#    select jobwork customer  Customer0604
#    date entry
#    set ith item in outward  0  ${itemData4}[0]  ${itemData4}[1]
#    click  ${submit}
#    click  ${newRequest}
#    approve outward
#
#outward to prod
#    login
#    open trasactions page
#    click  ${outwardTab}
#    click  ${newOutwardNote}
#    select outward to  Production
#    select machine  WIP Section
#    date entry
#    set ith item in outward  0  ${itemData5}[0]  ${itemData5}[1]
#    click  ${submit}
#    click  ${newRequest}
#    open trasactions page
#    click  ${outwardTab}
#    sleep  2
#    outward tr status no method 2  Pending  1
#    click  //div[@id = "item__tabs-panel-debit"]/div/div/div/div/div/div/div/div[2]/table/tbody/tr[2]/td[1]/div/span/a
#    click  ${edit}
#    edit ith item in outward  0  ${edititemData5}[0]  ${edititemData5}[1]
#    click  ${submit}
#    i should see text on page  Transaction Edited SuccesFully
#    approve outward


