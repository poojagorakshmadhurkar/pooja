*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData1}  RMItem-5  44

*** Test Cases ***
Withdrawing inward transaction
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomation
    open transactions page
    sleep  1
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test_Employee07
    select partner  Vendor1113
    input  ${invoiceNumber}  inv1001
    ${text}    Get Value    ${InwardGRNfield}
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open transactions page
    inward tr status no method 2  Pending  1
    open inward tr note  1
    click  ${withdrawButton}
    i should see text on page  Request note disapproved SuccesFully
    reload page
    sleep  2
    inward transaction search through GRN  ${text}
    inward tr status no method 2  Withdrawn  1


Withdrawing outward transaction

    login
    select site  testingsiteautomation
    open transactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Cust-003
    date entry
    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open transactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    open outward tr note  1
    ${text}    Get text    ${withdrawButton}/../div/div[1]
    click  ${withdrawButton}
    i should see text on page  Request note disapproved SuccesFully
    reload page
    sleep  2
    outward transaction search through GRN  ${text}
    outward tr status no method 2  Withdrawn  1

