*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String
Library  Browser

*** Keywords ***
open warehouses page
    click  ${mastersDropdown}
    click  ${mastersWarehouses}
    Wait For Elements State    //h5[normalize-space()='warehouses']

warehouse should be added
    [Arguments]  ${warehouseName}
    click  (//*[name()='svg'][@id='undefined_Name_search'])[1]
    click  //input[@placeholder='Search Name']
    Fill Text   //input[@placeholder='Search Name']  ${warehouseName}
    click  (//*[name()='svg'][@id='undefined_Name_search'])[2]
    Wait For Elements State  //a[text() = "${warehouseName}"]  timeout=15s

warehouse rack inititation
    [Arguments]  ${i}  ${rackName}  ${count}
    input  //input[@id = "warehouse__rack__prefix__${i}"]  ${rackName}
    input  //input[@id = "warehouse__rack__count__${i}"]  ${count}

Pre-Approval Params
    [Arguments]  ${i}  ${RequestTypevalue}  ${PartnerTypevalue}  ${ApprovalCheckvalue}
    select option from dropdown using span  //input[@id = "warehouse__params__request_type__${i}"]/..  ${RequestTypevalue}
    select option from dropdown using span  //input[@id = "warehouse__params__partner_type__${i}"]/..  ${PartnerTypevalue}
    select option from dropdown using span  //input[@id = "warehouse__params__approval_check__${i}"]/..  ${ApprovalCheckvalue}

edit warehouse
    [Arguments]  ${oldWarehouseName}  ${newWarehouseName}  ${newLinkedWarehousePartners}  ${newRequestType}  ${newPartnerType}  ${newApprovalCheck}
    click  //a[text() = "${oldWarehouseName}"]
    click  ${itemedit}
    ${randomWarehouseName}=  generate random string
    Clear Text    ${warehouseName}
    Type text   ${warehouseName}   ${randomWarehouseName}
#    browser.press keys  ${linkedWarehousePartners}  BACKSPACE  BACKSPACE  BACKSPACE  ${newLinkedWarehousePartners}  ARROW_DOWN  ENTER  ESC
#    click  //span[text()="Linked Partners"]
    Pre-Approval Params  0  Inward  Vendor  Validation of items
#    Pre-Approval Params  1  Outward  Customer  Quality Check

#    press keys  //input[@id = "warehouse__rack__prefix__${i}"]  CTRL+A  BACKSPACE  ${newRack}
#    press keys  //input[@id = "warehouse__rack__count__${i}"]  CTRL+A  BACKSPACE  ${newRackQuantity}
#    click  (//span[@aria-label="close-circle"])[2]
#    click  //span[text() = "Outward"]
#    click  (//span[@aria-label="close-circle"])[3]
#    click  //span[text() = "Jobwork Customer"]
#    click  (//span[@aria-label="close-circle"])[4]
#    click  //span[text() = "Validation of items"]
    click  ${Submit}
    i should see text on page  Warehouse edited
    open warehouses page
    Reload
    warehouse should be added  ${randomWarehouseName}
#    warehouse deletion check
    click  (//a[text() = "${randomWarehouseName}"]/../../../../../../../../../td[3]//button)[2]
    click  ${deactivateWarehouse}
    i should see text on page  Warehouse deactivated successfully

warehouse deletion check
    [Arguments]  ${warehouseName}
    Wait For Elements State  //table/tbody/tr/th/span[text() = "${warehouseName}"]  1
    Wait For Elements State   //table/tbody/tr/th/span[text() = "${warehouseName}"]


select option from dropdown by input
    [Arguments]  ${dropdownXpath}  ${option}
    input  ${dropdownXpath}  ${option}
    Wait For Elements State  (//span[text() = "${option}"])[2]  visible  timeout=60
    click  (//span[text() = "${option}"])[2]