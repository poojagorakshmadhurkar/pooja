*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections


*** Variables ***
@{CustomerData1}  Pooja908      #change here name


*** Test Cases ***
customer creation
    [Tags]  creation
    login
    select site  smart_factory
    open customer page
    #wait until page contains  NEW  20
    click  ${addNewCustomer}
    sleep  5
#    ${randomCustomerName}=  generate random string  5-10  [LETTERS]
    input  ${customerName}  ${CustomerData1}[0]
    select option from dropdown using span  ${typeOfPartner}  Customer
#    select randomly from dropdown  ${typeOfPartner}
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    input  ${customerEmail}  ${randomCustomerEmail}
#    select option from dropdown using span  ${customerSM}  Smart Admin
    ${randomCustomerAddress}=  generate random string  5-15  [LETTERS]
    input  ${customerAddress}  ${randomCustomerAddress}
    select option from dropdown using span  ${customerCountry}  India
    select option from dropdown using span  ${customerState}  Bihar
    select option from dropdown using span  ${customerCity}  Arrah
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    input  ${customerGSTN}  ${randomGSTN}
#    Get Random Value  ${customerCountry}
#    ${stateXpathCount}=  get element count  ${customerState}
#    IF  ${stateXpathCount} == 1
#        select randomly from dropdown  ${customerState}
#    END
#    ${cityXpathCount}=  get element count  ${customerCity}
#    IF  ${cityXpathCount} == 1
#        select randomly from dropdown  ${customerCity}
#    END
    click  ${Submit}
    click  ${newRequest}
    open customer page
    reload page
    wait until page contains  NEW  15
    customer should be added  ${CustomerData1}[0]
    sleep  5

edition of random genarated customer
    edit random generated customer  ${CustomerData1}[0]
customer deletion
    [Tags]  deletion
    delete customer  ${CustomerData2}[0]
    i should see text on page  Partner deactivated successfully