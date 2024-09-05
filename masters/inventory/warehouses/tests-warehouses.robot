*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

*** Variables ***
@{warehouseNameData}  mainSite20      #change name here
@{linkedPartnersData}  Dixit
@{EditWarehouseData}  EditedMainSite19  Bajaj  Inward  Vendors  Validation of items
                      #change name here only
*** Test Cases ***
open warehouses page
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open warehouses page
    click  ${addNewWarehouses}
    ${randomWarehouseName}=  generate random string  5-10  [LETTERS]
    input  ${warehouseName}  ${randomWarehouseName}
    ${toEditWarehouse}  Set Variable   ${warehouseName}
    press keys  ${linkedWarehousePartners}  ${linkedPartnersData}[0]  ARROW_DOWN  ENTER  ESC
    sleep  1
    click  //span[text()="Linked Partners"]
    click  //button[@id="warehouse__params__add"]
#    warehouse rack inititation  0  M  1
    Pre-Approval Params  1  Outward  Customer  Quality Check
#    click  ${preApprovalParamAdd}
#    Pre-Approval Params  1  Inward  Vendor  Validation of items
    click  ${autoGrnButton}
    click  ${Submit}
    i should see text on page  Warehouse added
    open warehouses page
    reload page
    sleep  4
    warehouse should be added  ${randomWarehouseName}
    edit warehouse  ${randomWarehouseName}  ${EditWarehouseData}[0]  ${EditWarehouseData}[1]  ${EditWarehouseData}[2]  ${EditWarehouseData}[3]  ${EditWarehouseData}[4]


