*** Settings ***
Library   SeleniumLibrary
Library   String
Library   Collections
Library   DateTime
Resource   ../../variables.robot
Resource   ../../keywords.robot
Resource   ./Variable1.robot
Resource   ./Keyword1.robot
Resource   ../../inventory/warehouses/keywords.robot
Resource   ../../orders/Salesorder/keywords.robot
Resource   ../../orders/Salesorder/variables.robot
Resource   ../../orders/PurchaseOrder/keyword.robot
Resource   ../../orders/PurchaseOrder/variable.robot
Resource   ../../inventory/Rework_Reuse_Scrap/Variable1.robot
Resource   ../../inventory/transactions/keywords.robot

*** Variables ***
@{customername}  Test_Customer
@{itemData1}  FG_1  10  5
#@{itemData}  Fgitem1  100  50
@{rejection}  BUBBLES  Missmatch  2
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  WIP_1
${shift}  Morning

*** Test Cases ***
Verify Rejection and Rewark From Production Entry
#    Set Selenium Speed    0.05s
##    Login To Dev Site
##    maximize browser window
#    Open Browser In Headless Mode
##    select site  testingsiteautomation
#
#    wait until page contains element    ${INVENTRY}   30s
#    #    *******************************************************
#    #                     INITIAL CURRENT QTY
#    #    *******************************************************
#    mouse over    ${INVENTRY}
#    click    ${WAREHOUSES}
#    click    ${REFRESH}
#    click    ${FG}
#    Search Item in Item Details   ${itemData1}[0]  2   1   3
#    sleep    1s
#    ${Initial_Current_Stock}=   get text    ((//span[text()='${itemData1}[0]'])[2]/../../../../../../../../../..//td[3])[2]
#    log   ✅ Before Rejection & rework Current stock of this item " ${itemData1}[0] " = ✅ ${Initial_Current_Stock}
#
#    #    Remove unit of current qty
#    ${Initial_Current_Stock_qty}  Evaluate  ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) if ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) else '0'
#    ${Initial_Current_qty_without_Unit}  Convert To Integer  ${Initial_Current_Stock_qty}
#    log   ✅ Initial Qty without unit = ✅ ${Initial_Current_qty_without_Unit}
#
#    ${order_number}=  Keyword1.Create_SO  ${customername}  ${itemData1}
#    click  //a[text()="${order_number}"]/../../../../../../../../span
#    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
#    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
#    #check the items quanity in warehouse
#    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
#    open production Dropown
#    reload page
#    select machinesSo  ${machine}[0]
#    sleep   1
#    select ShiftsSo  ${shift}
#    date entryproduction
#    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
#    click element   ${intervalDropdown}     #interval dropfown
#    select salesorder  ${order_number}
#    sleep  2
#    click  ${productionsubmitbutton}
#    sleep  2
#    wait until element is visible  //b[text()="Allocated to : "]
#    #Production Entries
#    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[2]
#    sleep  1
#    click  ${productionformsubmitbtn}
#    sleep  2
#    Open Order Tracker Page
#    search Sonumber in SoListpage for validation  ${order_number}
#    click  //a[text()="${order_number}"]/../../../../../../../../span
#    sleep  1
#    #verification of production entry is Salesorder
#    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][2]     #booked Quantity
##    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][3]     #produced Quantity
#    sleep  2
#   #to get rejected current Quantity
#    open warehouse
#    sleep  2
#    reload page
#    click  ${rejectedsection}
#    #to fetch rejected current quantity of summary view
#    ${rejectedsummaryQuantity1} =  rejected current quantity of summary view    ${itemData1}[0]
#    sleep  1
#    #To fetch rejected curent Quantity of detailted view
#    ${rejecteddetailedQuantity1} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
#    reload page
#    ${rejecteddetailedQuantity2} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
#    sleep  1
#    open production Dropown
#    reload page
#    select machinesSo  ${machine}[0]
#    sleep   1
#    select ShiftsSo  ${shift}
#    date entryproduction
#    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
#    click element   ${intervalDropdown}     #interval dropfown
#    select salesorder  ${order_number}
#    sleep  2
#    click  ${productionsubmitbutton}
#    sleep  2
#    wait until element is visible  //b[text()="Allocated to : "]
#    click  ${edit}
#    #rejction entry in production
#    click  ${rejectedbutton}
#    rejectionprodform  1  ${rejection}[0]  ${rejection}[2]
#    rejectionprodform  2  ${rejection}[1]  ${rejection}[2]
#    click  ${productionformsubmitbtn}
#    Open Order Tracker Page
#    search Sonumber in SoListpage for validation  ${order_number}
#    click  //a[text()="${order_number}"]/../../../../../../../../span
#    sleep  2
#    # verification rejection entry
#    ${bookedQuantity}  Evaluate  ${itemData1}[2] - ${rejection}[2] - ${rejection}[2]      #booked Quantity
#    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${bookedQuantity} piece"]
#    ${producedQuantity}  Evaluate  ${itemData1}[2] + ${rejection}[2] + ${rejection}[2]
#    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${producedQuantity} piece"]
#    #verification of rejected Quantity in warehouse
#    sleep  1
#    open warehouse
#    reload page
#    click  ${rejectedsection}
#    #to fetch rejected current quantity
#    ${rejectedsummaryQuantity2} =  rejected current quantity of summary view    ${itemData1}[0]
#    ${finalrejectedsummaryQuantity}  Evaluate  eval("${rejectedsummaryQuantity1}+${rejection}[2]+${rejection}[2]")
#    Should Be Equal As Integers    ${finalrejectedsummaryQuantity}    ${rejectedsummaryQuantity2}
#    #to fetch qauntity from detailed view
#    sleep  1
#    ${rejecteddetailedQuantity3} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
#    reload page
#    ${rejecteddetailedQuantity4} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
#    #Validation for rejected quanity detailed view
#    ${finalrejectedetailed1Quantity}  Evaluate  eval("${rejecteddetailedQuantity1}+${rejection}[2]")
#    Should Be Equal As Integers    ${finalrejectedetailed1Quantity}    ${rejecteddetailedQuantity3}
#    ${finalrejectedetailed2Quantity}  Evaluate  eval("${rejecteddetailedQuantity2}+${rejection}[2]")
#    Should Be Equal As Integers    ${finalrejectedetailed2Quantity}    ${rejecteddetailedQuantity4}
#
#
#
#
##    click    ${CLICK_MACHINE_SEARCH}[2]
##    Select Machine    ${machine}[0]
##    click    ${CLICK_MACHINE_SEARCH}[3]
#    click    ${REWORK_BTN}
#    input    ${ENTER_REWORK_INPUTBOX}   2
#    click    ${SUBMIT}
#    ${REWARK_SUCESSFULLY_MSG_NOTE}=     get text    ${REWARK_NOTE_MSG}
#    log    ✅ ${REWARK_SUCESSFULLY_MSG_NOTE}
#    mouse over    ${INVENTRY}
#    click    ${TRANSACTIONS}
#    click    ${OUTWARD}
#    click    ${CLICK_ON_ROW}
#
#   ${Remaning}    Evaluate    ((${itemData1}[1])  -  3)
#   ${Remaining} = (${itemData1}[1] - 3)

   ${Total}    Evaluate    (${itemData1}[1] - 4)
   log to console   ${Total}



