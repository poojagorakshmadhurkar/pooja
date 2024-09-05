*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String

*** Keywords ***
open warehouses page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersWarehouses}

warehouse should be added
    [Arguments]  ${warehouseName}
    click  //*[name()='path' and contains(@d,'M10 18h4v-')]
    press keys  //input[@id='name']  CTRL+A  BACKSPACE
    input  //input[@id='name']  ${warehouseName}
    sleep  5
    wait until page contains element  //a[text() = "${warehouseName}"]  timeout=15s

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
    click  ${edit}
    ${randomWarehouseName}=  generate random string
    press keys  ${warehouseName}  CTRL+A  BACKSPACE  ${randomWarehouseName}
    press keys  ${linkedWarehousePartners}  BACKSPACE  BACKSPACE  BACKSPACE  ${newLinkedWarehousePartners}  ARROW_DOWN  ENTER  ESC
    click  //span[text()="Linked Partners"]
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
    reload page
    sleep  4
    warehouse should be added  ${randomWarehouseName}
    sleep  2
#    warehouse deletion check
    click  //a[text() = "${randomWarehouseName}"]/../../../../../../../../../../td/div/button[@aria-label = "Deactivate"]
    click  ${deactivateWarehouse}
    i should see text on page  Warehouse deactivated successfully

warehouse deletion check
    [Arguments]  ${warehouseName}
    wait until element is not visible  //table/tbody/tr/th/span[text() = "${warehouseName}"]  1
    element should not be visible  //table/tbody/tr/th/span[text() = "${warehouseName}"]


