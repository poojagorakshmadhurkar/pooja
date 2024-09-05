*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library  ../customkeyword.py



#*** Variables ***
#@{VendorData2}  Newvendor106     #change name here
*** Keywords ***
open vendor page
    click  ${mastersDropdown}
    click  ${mastersVendors}
    reload page

vendor should be added
    [Arguments]  ${vendorName}
    click  (//*[name()='svg'][@id='vendors_Name_search'])[1]
    sleep  3
    press keys  (//input[@placeholder='Search Name'])[1]  CTRL+A  BACKSPACE
    input  (//input[@placeholder='Search Name'])[1]  ${vendorName}
    press keys  (//input[@placeholder='Search Name'])[1]  ENTER
    wait until page contains element  //span[text() = "${vendorName}"]  timeout=20s



edit random generated vendor
    [Arguments]  ${oldVendorName}  ${VendorData2}
    sleep  2
    click  //span[text() = "${oldVendorName}"]/../span/span/span/a
    click  //button[text() = "Edit"][2]
    press keys  ${vendorName}  CTRL+A  BACKSPACE  ${VendorData2}
    ${randomVendorEmail}=  generate random string  5-10  [LETTERS]
    press keys  ${vendorEmail}  CTRL+A  BACKSPACE  ${randomVendorEmail}
    ${randomVendorAddress}=  generate random string  5-15  [LETTERS]
    press keys  ${vendorAddress}  CTRL+A  BACKSPACE  ${randomVendorAddress}
    Select Option from Dropdown DIV value  ${customerCountryXpath}  Albania
    select option from dropdown DIV value  ${customerStateXpath}  Berat County
#    select option from dropdown using div  ${vendorCity}  Banaj
    ${randomGSTNnew}=  generate random string  10-15  [NUMBERS]
    press keys  ${vendorGSTN}  CTRL+A  BACKSPACE  ${randomGSTNnew}
    click  ${Submit}
    i should see text on page  Partner edited
    open vendor page
    reload page
    sleep  2
    wait until page contains  NEW  15
    vendor should be added  ${VendorData2}
    sleep  3

delete vendor
    [Arguments]  ${vendorName}
    click  //span[text()="${vendorName}"]/../../../../../../td[7]//button
    click  ${deactivate_vendor}

vendor deletion check
    [Arguments]  ${vendorName}
    wait until element is not visible  //table/tbody/tr/th/span[text() = "${vendorName}"]  1
    element should not be visible  //table/tbody/tr/th/span[text() = "${vendorName}"]

Select Option from Dropdown DIV value
    [Arguments]  ${dropdownXpath}  ${option}
    Click  ${dropdownXpath}
    Wait Until Element Is Visible  xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]  timeout=10s
    Scroll Element Into View  xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]
    Click  xpath=//div[@class="ant-select-item-option-content" and text()="${option}"]


Generate Random Customer Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}