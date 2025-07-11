*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  Browser


*** Variables ***
#@{CustomerData1}  Pooja908      #change here name


*** Test Cases ***
customer creation
    [Tags]  creation
    login devsite
    select site  testingsiteautomation
    open customer page
    sleep  1
    click  ${addNewCustomer}
    ${randomCustomerName}=  generate random string  5-10  [LETTERS]
    ${CustomerData1}=  Generate Random Customer Name
    Fill Text   ${customerName}  ${CustomerData1}
#    select option from dropdown using span  ${typeOfPartner}  Customer
#    select randomly from dropdown  ${typeOfPartner}
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    Fill Text    ${customerEmail}  ${randomCustomerEmail}
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    Fill Text    ${customerGSTN}  ${randomGSTN}
    click  ${Submit}
    click  ${newRequest}
    open customer page
    Reload
    customer should be added  ${CustomerData1}
    ${CustomerData2}=  Generate Random Customer Name
#edition customer flow
    edit random generated customer  ${CustomerData1}  ${CustomerData2}
    delete customer  ${CustomerData2}
    i should see text on page  Partner deactivated successfully