*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library  ../customkeyword.py
Library  Browser



#*** Variables ***
#@{VendorData2}  Newvendor106     #change name here
*** Keywords ***

open vendor page
    click  ${mastersDropdown}
    click  ${mastersVendors}
    sleep  1
    Reload



vendor should be added
    [Arguments]  ${vendorName}
    click  (//*[name()='svg'][@id='vendors_Name_search'])[1]
    click  (//input[@placeholder='Search Name'])[1]
    Fill Text    (//input[@placeholder='Search Name'])[1]  ${vendorName}
    click  (//*[name()='svg'][@id='vendors_Name_search'])[2]
    Wait For Elements State    //span[text() = "${vendorName}"]  timeout=20s



edit random generated vendor
    [Arguments]  ${oldVendorName}  ${VendorData2}
    click  //span[text() = "${oldVendorName}"]/../span/span/span/a
    click  (//button[text() = "Edit"])[2]
    Fill Text   ${vendorName}   ${VendorData2}
    ${randomVendorEmail}=  generate random string  5-10  [LETTERS]
    Fill Text    ${vendorEmail}   ${randomVendorEmail}
    ${randomVendorAddress}=  generate random string  5-15  [LETTERS]
    ${randomGSTNnew}=  generate random string  10-15  [NUMBERS]
    Fill Text    ${vendorGSTN}   ${randomGSTNnew}
    click  ${Submit}
    i should see text on page  Partner edited
    open vendor page
    Reload
    vendor should be added  ${VendorData2}


delete vendor
    [Arguments]  ${vendorName}
    click  //span[text()="${vendorName}"]/../../../../../../td[7]//button
    click  ${deactivate_vendor}

vendor deletion check
    [Arguments]  ${vendorName}
    Wait For Elements State   //table/tbody/tr/th/span[text() = "${vendorName}"]  1
    Wait For Elements State    //table/tbody/tr/th/span[text() = "${vendorName}"]

Select Option from Dropdown DIV value
    [Arguments]  ${dropdownXpath}  ${option}
    click    ${dropdownXpath}
    Wait For Elements State    xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]    visible    timeout=10s
    Scroll To Element    xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]
    click    xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]


Generate Random Customer Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    RETURN  ${random_customer_name}