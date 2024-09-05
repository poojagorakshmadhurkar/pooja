*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot


*** Variables ***
#@{CustomerData1}  Pooja908      #change here name


*** Test Cases ***
customer creation
    [Tags]  creation
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open customer page

    #wait until page contains  NEW  20
    click  ${addNewCustomer}
    sleep  5
    ${randomCustomerName}=  generate random string  5-10  [LETTERS]
    ${CustomerData1}=  Generate Random Customer Name
    input  ${customerName}  ${CustomerData1}
    select option from dropdown using span  ${typeOfPartner}  Customer
#    select randomly from dropdown  ${typeOfPartner}
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    input  ${customerEmail}  ${randomCustomerEmail}
#    select option from dropdown using span  ${customerSM}  Smart Admin
    ${randomCustomerAddress}=  generate random string  5-15  [LETTERS]
    input  ${customerAddress}  ${randomCustomerAddress}
    Select Option from Dropdown DIV value    ${customerCountryXpath}  Afghanistan
    Select Option from Dropdown DIV value  ${customerStateXpath}  Badakhshan
    Select Option from Dropdown Using Div  ${customerCityXpath}  Ashkāsham
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    input  ${customerGSTN}  ${randomGSTN}
    click  ${Submit}
    sleep  1
#    ${success_message}=  Get Text  xpath=//div[contains(text(),'has been created!')]
#    Log  ${success_message}
#    ${customer_id}=  Extract Customer ID  ${success_message}
#    Log  ${customer_id}
    click  ${newRequest}
    open customer page
    reload page
    wait until page contains  NEW  15
    customer should be added  ${CustomerData1}
    sleep  5
    ${CustomerData2}=  Generate Random Customer Name
#edition customer flow
    edit random generated customer  ${CustomerData1}  ${CustomerData2}
    delete customer  ${CustomerData2}
    i should see text on page  Partner deactivated successfully