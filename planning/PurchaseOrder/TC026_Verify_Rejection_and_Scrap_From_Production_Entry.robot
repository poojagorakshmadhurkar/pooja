*** Settings ***
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Library   String
Library   Collections
Library   DateTime
Resource   ../../variables.robot
Resource   ../../keywords.robot
Resource   ../../inventory/warehouses/keywords.robot
Resource   ../../planning/Salesorder/keywords.robot
Resource   ../../planning/Salesorder/variables.robot
Resource   ../../planning/PurchaseOrder/keyword.robot
Resource   ../../planning/PurchaseOrder/variable.robot
Resource   ../../inventory/Rework_Reuse_Scrap/Variable1.robot
Resource   ../../inventory/transactions/keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
${expected_text}    Issued
@{customername}  Test01     #Test10
@{itemData1}    Fgitem1  100  50    #FG-00011  20   10
@{rejection}  CheckNUt  Damage  10
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  P2
${shift}  Morning Shift

*** Test Cases ***
Verify Rejection From Production Entry
    Open Browser Site
    login to manufapp site
    wait until page contains element    ${INVENTRY}   30s
    #    *******************************************************
    #                     INITIAL CURRENT QTY
    #    *******************************************************
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    click    ${REFRESH}
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    ${Initial_Current_Stock}=   get text    (//span[text()='${ItemData}[1]'])[1]/../../../../../../../../..//td[3]
    log   ✅ Before Rejection & rework Current stock of this item " ${ItemData}[1] " = ✅ ${Initial_Current_Stock}

    #    Remove unit of current qty
    ${Initial_Current_Stock_qty}  Evaluate  ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) if ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) else '0'
    ${Initial_Current_qty_without_Unit}  Convert To Integer  ${Initial_Current_Stock_qty}
    log   ✅ Initial Qty without unit = ✅ ${Initial_Current_qty_without_Unit}
    #    *******************************************************
#                         INITIAL  REJECTION QTY
    #    *******************************************************
    click   ${REJECTED}
    click    ${REFRESH}
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   2   4
    wait until element is visible    //*[@data-row-key="124581"]//td[5]
    ${Before_Rejected}=    get text    //*[@data-row-key="124581"]//td[5]
    log    ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ✅ ${Before_Rejected}

    ${Initial_Rejection_Qty}  Evaluate  ''.join(c for c in "${Before_Rejected}" if c.isdigit()) if ''.join(c for c in "${Before_Rejected}" if c.isdigit()) else '0'
    ${Initial_Total_Rejection_Qty}  Convert To Integer  ${Initial_Rejection_Qty}
    log   ✅ ${Initial_Total_Rejection_Qty}
    mouse over   ${ORDERS}
    Create_SO   ${customername}   ${itemData1}
#    click   ${SO_NUMBER}
#    sleep   1s
    page should contain element   ${ITEM_NAME1}    20s
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    click   ${CLICK_ITEM}
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[1]
    Click    //button[@class='ant-switch ant-switch-small'][@role='switch']
    go to   ${NEXT_TAB}=Next Page
    click   ${EXPAND_ALL}
    go back
    click   ${CREATE_WO}
    click   ${MACHINE}
    click   ${PLAN ALL}
    click   ${REVIEW CHNAGES}
    click   ${CREATE}
    click   ${WO}

