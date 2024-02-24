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
    login
    open vendor page
    wait until page contains  NEW  15
    click  ${addNewVendor}
    input  ${vendorName}  ${VendorData1}[0]
    select option from dropdown using span  ${typeOfPartner}  Vendor
    input  ${vendorEmail}  ${VendorData1}[1]
    input  ${vendorAddress}  ${VendorData1}[2]
    select option from dropdown using span  ${vendorCountry}  Afghanistan
    select option from dropdown using span  ${vendorState}  Badakhshan
    select option from dropdown using span  ${vendorCity}  Jurm
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    input  ${vendorGSTN}  ${randomGSTN}
    click  ${Submit}
    i should see text on page  Partner added
    click  ${newRequest}
    click  ${back}
    reload page
    wait until page contains  NEW  15
    vendor should be added  ${VendorData1}[0]
    sleep  3

vendor edition
    edit random generated vendor  ${VendorData1}[0]


delete vendor
    delete vendor  ${VendorData2}[0]
    i should see text on page  Partner deactivated successfully
#    vendor deletion check