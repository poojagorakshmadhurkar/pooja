*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collection
Library  Browser
#Resource  ../../keywords.robot



#*** Variables ***
#@{VendorData1}  Vendor109  test9@gmail.com  test39address       #change name only detials here

*** Test Cases ***
vendorCreation

    login devsite
    select site  testingsiteautomation
    open vendor page
    ${VendorData1}=  Generate Random Customer Name
    sleep  1
    click  ${addNewVendor}
    Fill Text   ${vendorName}  ${VendorData1}
#    select option from dropdown using span  ${typeOfPartner}  Vendor
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    Fill Text    ${vendorEmail}  ${randomCustomerEmail}
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    Fill Text    ${vendorGSTN}  ${randomGSTN}
    click  ${Submit}
    i should see text on page  Partner added
    click  ${newRequest}
    click  ${vendorback}
    Reload
    sleep  1
    vendor should be added  ${VendorData1}
    sleep  1
    ${VendorData2}=  Generate Random Customer Name
    edit random generated vendor  ${VendorData1}  ${VendorData2}
    delete vendor  ${VendorData2}
    i should see text on page  Partner deactivated successfully
#    vendor deletion check