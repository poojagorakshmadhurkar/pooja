*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{warehouseNameData}  mainSite20      #change name here
@{linkedPartnersData}  Dixit
@{EditWarehouseData}  EditedMainSite19  Bajaj  Inward  Vendors  Validation of items
                      #change name here only
*** Test Cases ***
open warehouses page
    login
    select site  smart_factory
    open warehouses page
    click  ${addNewWarehouses}
#    ${randomWarehouseName}=  generate random string  5-10  [LETTERS]
    input  ${warehouseName}  ${warehouseNameData}[0]
    ${toEditWarehouse}  Set Variable   ${warehouseName}
    press keys  ${linkedWarehousePartners}  ${linkedPartnersData}[0]  ARROW_DOWN  ENTER  ESC
#    warehouse rack inititation  0  M  1
    Pre-Approval Params  0  Outward  Customer  Quality Check
#    click  ${preApprovalParamAdd}
#    Pre-Approval Params  1  Inward  Vendor  Validation of items
    click  ${autoGrnButton}
    click  ${Submit}
    i should see text on page  Warehouse added
    open warehouses page
    reload page
    sleep  4
    warehouse should be added  ${warehouseNameData}[0]

warehouse edition
    edit warehouse  ${warehouseNameData}[0]  ${EditWarehouseData}[0]  ${EditWarehouseData}[1]  ${EditWarehouseData}[2]  ${EditWarehouseData}[3]  ${EditWarehouseData}[4]
    i should see text on page  Warehouse edited
    open warehouses page
    reload page
    sleep  4
    warehouse should be added  ${EditWarehouseData}[0]
    sleep  2

delete edited warehouse
    delete warehouse  ${EditWarehouseData}[0]
    i should see text on page  Warehouse deactivated successfully
#    warehouse deletion check

