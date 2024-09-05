*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collection
Resource  ../../keywords.robot



#*** Variables ***
#@{VendorData1}  Vendor109  test9@gmail.com  test39address       #change name only detials here

*** Test Cases ***
vendorCreation
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open vendor page
    wait until page contains  NEW  15
    ${VendorData1}=  Generate Random Customer Name
    click  ${addNewVendor}
    input  ${vendorName}  ${VendorData1}
    select option from dropdown using span  ${typeOfPartner}  Vendor
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    input  ${vendorEmail}  ${randomCustomerEmail}
#    select option from dropdown using span  ${customerSM}  Smart Admin
    ${randomCustomerAddress}=  generate random string  5-15  [LETTERS]
    input  ${vendorAddress}  ${randomCustomerAddress}
    Select Option from Dropdown DIV value    ${customerCountryXpath}  Afghanistan
    Select Option from Dropdown DIV value  ${customerStateXpath}  Badakhshan
    Select Option from Dropdown Using Div  ${customerCityXpath}  Ashkāsham
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    input  ${vendorGSTN}  ${randomGSTN}
    click  ${Submit}
    i should see text on page  Partner added
    click  ${newRequest}
    click  ${back}
    reload page
    wait until page contains  NEW  15
    vendor should be added  ${VendorData1}
    sleep  3
    ${VendorData2}=  Generate Random Customer Name
    edit random generated vendor  ${VendorData1}  ${VendorData2}
    delete vendor  ${VendorData2}
    i should see text on page  Partner deactivated successfully
#    vendor deletion check