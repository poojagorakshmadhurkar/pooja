*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot



#*** Variables ***
#@{VendorData2}  Newvendor106     #change name here
*** Keywords ***
open vendor page
    click  ${mastersDropdown}
    click  ${mastersVendors}

vendor should be added
    [Arguments]  ${vendorName}
    click  //button[@id="vendors__filterBtn"]
    sleep  3
    press keys  //input[@id='name']  CTRL+A  BACKSPACE
    input  //input[@id='name']  ${vendorName}
    wait until page contains element  //span[text() = "${vendorName}"]  timeout=20s



edit random generated vendor
    [Arguments]  ${oldVendorName}
    click  //span[text() = "${oldVendorName}"]/../span/span/span/a
    click  ${Edit}
    press keys  ${vendorName}  CTRL+A  BACKSPACE  ${VendorData2}[0]
    ${randomVendorEmail}=  generate random string  5-10  [LETTERS]
    press keys  ${vendorEmail}  CTRL+A  BACKSPACE  ${randomVendorEmail}
    ${randomVendorAddress}=  generate random string  5-15  [LETTERS]
    press keys  ${vendorAddress}  CTRL+A  BACKSPACE  ${randomVendorAddress}
    select option from dropdown using div  ${vendorCountry}  Albania
    select option from dropdown using div  ${vendorState}  Berat District
    select option from dropdown using div  ${vendorCity}  Banaj
    ${randomGSTNnew}=  generate random string  10-15  [NUMBERS]
    press keys  ${vendorGSTN}  CTRL+A  BACKSPACE  ${randomGSTNnew}
    click  ${Submit}
    i should see text on page  Partner edited
    open vendor page
    reload page
    sleep  2
    wait until page contains  NEW  15
    vendor should be added  ${VendorData2}[0]
    sleep  3

delete vendor
    [Arguments]  ${vendorName}
    click  //span[text() = "${vendorName}"]/../../../../../../../td[6]/div/button
    click  ${deactivate_vendor}

vendor deletion check
    [Arguments]  ${vendorName}
    wait until element is not visible  //table/tbody/tr/th/span[text() = "${vendorName}"]  1
    element should not be visible  //table/tbody/tr/th/span[text() = "${vendorName}"]