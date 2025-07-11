*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
Resource  ../Subcontracting/Keyword.robot
Resource  ../Subcontracting/Variable.robot
Resource  ../orders/PurchaseOrder/keyword.robot
Resource  ../orders/PurchaseOrder/variable.robot
Resource  ../inventory/Rework_Reuse_Scrap/Variable1.robot
Resource  ../inventory/Rework_Reuse_Scrap/Keyword1.robot
*** Variables ***
@{ItemData_RM}   RMR00027
@{ItemData_WIP}   001WIP
@{ItemData_FG}   KGT
*** Test Cases ***
Create Repair Request
    Login To ManufApp Site
    Hover  ${INVENTORY}
    Click  ${WAREHOUSES}
    Click  ${REFRESH}
    Hover  ${PLANNING_&_SCHEDULING}
    Click  ${REPAIR_REQUEST}
    sleep    0.5s
    Search Item in Item Details SearchBox   ${ItemData_RM}[0]  2   1   3
    Wait For Elements State    ${REJECTION_QTY}
    ${Before_Rejected}=    get text    ${REJECTION_QTY}
    log    ✅ (Before) Rejection Quantity of this Item " ${ItemData_RM}[0] " = ✅ ${Before_Rejected}
    #    Remove unit of current qty of rejection
    ${Initial_Rejection_Qty}  Evaluate  ''.join(c for c in "${Before_Rejected}" if c.isdigit()) if ''.join(c for c in "${Before_Rejected}" if c.isdigit()) else '0'
    ${Initial_Total_Rejection_Qty}  Convert To Integer  ${Initial_Rejection_Qty}
    log   ✅ ${Initial_Total_Rejection_Qty}


