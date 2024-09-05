*** Settings ***
Library   SeleniumLibrary
Library   String
Library   Collections
Library   DateTime
Resource   ../../inventory/warehouses/keywords.robot
Resource   ../../inventory/warehouses/variables.robot
Resource   ../../planning/Salesorder/keywords.robot
Resource   ../../planning/Salesorder/variables.robot
Resource   ../../planning/PurchaseOrder/keyword.robot
Resource   ../../planning/PurchaseOrder/variable.robot
Resource   ../../inventory/Rework_Reuse_Scrap/Variable1.robot
Resource   ../../inventory/transactions/keywords.robot
Resource   ./Variable1.robot
Resource   ./Keyword1.robot
Resource   ../../variables.robot
Resource   ../../keywords.robot

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100  50
#@{itemData}  Fgitem1  100  50
@{rejection}  CheckNUt  Damage  10
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  P2
${shift}  Morning Shift

*** Test Cases ***
Verify Rejection and Rewark From Production Entry
    Set Selenium Speed    0.01s
    login devsite
    select site  testingsiteautomation
    wait until page contains element    ${INVENTRY}   30s
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    click    ${REFRESH}
    click    ${FG}
    reload page
#   TO GET THE CURRENT QUANTITY OF FG SECTION
    Search Item in Item Details   ${itemData1}[0]  2   1   3
    ${Initial_Current_Stock}=   get text    ((//span[text()='Fgitem1'])[2]/../../../../../../../../../..//td[3])[2]
    log   🟡 Before Rejection & rework Current stock of this item " ${itemData1}[0] " = ✅ ${Initial_Current_Stock}
#   REMOVE UNIT OF CURRENT QUANTITY
    ${Initial_Current_Stock_qty}  Evaluate  ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) if ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) else '0'
    ${Initial_Current_qty_without_Unit}  Convert To Integer  ${Initial_Current_Stock_qty}
#   CURRENT QUANTITY IN FG SECTION
    log   🟡 Initial Qty without unit = ✅ ${Initial_Current_qty_without_Unit}
#   CREATE SO
    ${order_number}=  keywords.Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
#   FETCH ITEM DETAILS FROM BOM
    ${item1_value}    ${item2_value}    ${item3_value}=    Expand And FetchItems from BOM    ${itemData1}    ${xpath}
    #check the items quanity in warehouse
    Search and Check Item Quantity for Wipitem  ${item3_value}  ${itemData1}[1]  Poojatest01  Test01
    open production Dropown
    reload page
    select machinesSo  ${machine}[0]
    sleep   1s
    select ShiftsSo  ${shift}
    date entryproduction
    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
    click element   ${intervalDropdown}     #interval dropfown
    select salesorder  ${order_number}
    sleep   1s
    click  ${productionsubmitbutton}
    sleep   1s
    wait until element is visible  //b[text()="Allocated to : "]
    #Production Entries
    set ith item in productionForm  0  ${itemData1}[0]  ${itemData1}[2]
    sleep   1s
    click  ${productionformsubmitbtn}
    sleep   1s
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep   1s
    #verification of production entry is Salesorder
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][2]     #booked Quantity
#   wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${itemData1}[2] piece"][3]     #produced Quantity
    sleep   1s
   #to get rejected current Quantity
    open warehouse
    sleep   1s
    reload page
    click  ${rejectedsection}
    #to fetch rejected current quantity of summary view
    ${rejectedsummaryQuantity1} =  rejected current quantity of summary view    ${itemData1}[0]
    log   ⛔ Rejected Qty in Summary view = ${rejectedsummaryQuantity1}
    sleep   1s
    #To fetch rejected curent Quantity of detailted view
    ${rejecteddetailedQuantity1} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
    log   ⛔ Rejected Qty in details view = ${rejecteddetailedQuantity1}
    reload page
    ${rejecteddetailedQuantity2} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    log   ⛔ Rejected Qty in Summary view = ${rejecteddetailedQuantity2}
    sleep   1s
    open production Dropown
    reload page
    select machinesSo  ${machine}[0]
    sleep   1s
    select ShiftsSo  ${shift}
    date entryproduction
    Wait Until Element Is Not Visible    ${loaderinterval}    timeout=30s
    click element   ${intervalDropdown}     #interval dropfown
    select salesorder  ${order_number}
    sleep   1s
    click  ${productionsubmitbutton}
    sleep   1s
    wait until element is visible  //b[text()="Allocated to : "]
    click  ${edit}
    #rejction entry in production
    click  ${rejectedbutton}
    rejectionprodform  1  ${rejection}[0]  ${rejection}[2]
    rejectionprodform  2  ${rejection}[1]  ${rejection}[2]
    click  ${productionformsubmitbtn}
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep   1s
    # verification rejection entry
    ${bookedQuantity}  Evaluate  ${itemData1}[2] - ${rejection}[2] - ${rejection}[2]      #booked Quantity
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${bookedQuantity} piece"]
    ${producedQuantity}  Evaluate  ${itemData1}[2] + ${rejection}[2] + ${rejection}[2]
    wait until element is visible  (//div[@id="item__tabs-panel-1"]//table)[2]//td[text()="${producedQuantity} piece"]
    #verification of rejected Quantity in warehouse
    sleep   1s
    open warehouse
    reload page
    click  ${rejectedsection}
    #to fetch rejected current quantity
    ${rejectedsummaryQuantity2} =  rejected current quantity of summary view    ${itemData1}[0]
    ${finalrejectedsummaryQuantity}  Evaluate  eval("${rejectedsummaryQuantity1}+${rejection}[2]+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedsummaryQuantity}    ${rejectedsummaryQuantity2}
    #to fetch qauntity from detailed view
    sleep   1s
    ${rejecteddetailedQuantity3} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[0]
    reload page
    ${rejecteddetailedQuantity4} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    #Validation for rejected quanity detailed view
    ${finalrejectedetailed1Quantity}  Evaluate  eval("${rejecteddetailedQuantity1}+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedetailed1Quantity}    ${rejecteddetailedQuantity3}
    ${finalrejectedetailed2Quantity}  Evaluate  eval("${rejecteddetailedQuantity2}+${rejection}[2]")
    Should Be Equal As Integers    ${finalrejectedetailed2Quantity}    ${rejecteddetailedQuantity4}
#    Rework Qty
    click    ${REWORK_BTN}
    input    ${ENTER_REWORK_INPUTBOX}   10
    click    ${SUBMIT2}
    sleep   1s
    ${REWARK_SUCESSFULLY_MSG_NOTE}=     get text    ${REWARK_NOTE_MSG}
    log   ✅ ${REWARK_SUCESSFULLY_MSG_NOTE}
    mouse over    ${INVENTRY}
    click    ${TRANSACTIONS}
    click    ${OUTWARD}
    click    ${CLICK_PENDING_TEXT}
    sleep   1s
    ${REWORK_NOTE_ID}=   get text   ${REWORK_ID_IN_OUTWARD}
    log   ✅ ${REWORK_NOTE_ID}
    click   ${CANCEL_ICON}
    Search Note in MRN Issue Searchbox     ${REWORK_NOTE_ID}
    wait until page contains element    (//*[@id="transaction_debit_approve"])[3]
    sleep   1s
    click   ${APPROVE_FOR_DEBIT}
    sleep   1s
    ${MRR_NOTE}=    get text    ${MRN_APPROVE_NOTE}
    log   ✅ ${MRR_NOTE}
#    --------------------------------------------------------------------------------------------
#    CALCULATE EXPECTED FINAL QTY AFTER REJECTION AND REWORK
    ${FINAL_EXPECTED}     Evaluate    ((${Initial_Current_qty_without_Unit} + 50) - 20) + 10
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    reload page
    click    ${REFRESH}
    click    ${FG}
    Search Item in Item Details   ${itemData1}[0]  2   1   3
#    TO GET EXPECTED FINAL QTY AFTER REJECTION AND REWORK
    ${ACTUAL_Current_Stock}=   get text    ((//span[text()='Fgitem1'])[2]/../../../../../../../../../..//td[3])[2]
    log  🟡 Before Rejection & rework Current stock of this item " ${itemData1}[0] " = 🟡 ${ACTUAL_Current_Stock}
    #    Remove unit of current qty
    ${ACTUAL_Current_Stock}  Evaluate  ''.join(c for c in "${ACTUAL_Current_Stock}" if c.isdigit()) if ''.join(c for c in "${ACTUAL_Current_Stock}" if c.isdigit()) else '0'
    ${ACTUAL_Current_qty_without_Unit}  Convert To Integer  ${ACTUAL_Current_Stock}
#   ACTUAL FINAL QTY AFTER REJECTION AND REWORK
    log   🟡 Final Qty without unit = ✅ ${ACTUAL_Current_qty_without_Unit}
    Should Be Equal As Numbers    ${FINAL_EXPECTED}    ${ACTUAL_Current_qty_without_Unit}
    run keyword if    ${FINAL_EXPECTED} == ${ACTUAL_Current_qty_without_Unit}   Validation 3    ELSE IF   ${FINAL_EXPECTED} != ${ACTUAL_Current_qty_without_Unit}   Validation 4
#    ---------------------------------------------------------------------------------------------
#    CALCULATE EXPECTED REJECTION QTY AFTER REJECTION AND REWORK
    ${EXPECTED_QTY_OF_REJECTED}    Evaluate   (${finalrejectedsummaryQuantity} - 10)
    reload page
    sleep   2s
    wait until page contains    Live Inventory
    click    ${REFRESH2}
    sleep    0.05s
    click   ${REJECTED}
    sleep   0.05s
    #   SEARCH IN REJECTION TAB IN SUMMURY VIEW
    reload page
    Search Item in Item Details   ${ItemData1}[0]  2   1   3
    wait until element is visible    ${REJECTED_QTY_VALUE}
    ${FNL_REJECTION_QTY}=    get text    ${REJECTED_QTY_VALUE}
    log   ✅ (Before) Rejection Quantity of this Item " ${ItemData1}[0] " = ✅ ${FNL_REJECTION_QTY}
    #    Remove unit of current qty of rejection
    ${FNL_RJCN}  Evaluate  ''.join(c for c in " ${FNL_REJECTION_QTY}" if c.isdigit()) if ''.join(c for c in " ${FNL_REJECTION_QTY}" if c.isdigit()) else '0'
    ${FINAL_REJECTION_COUNT_IN_SUMMARY}  Convert To Integer  ${FNL_RJCN}
    log   ✅ ${FINAL_REJECTION_COUNT_IN_SUMMARY}
    Should Be Equal As Numbers    ${EXPECTED_QTY_OF_REJECTED}    ${FINAL_REJECTION_COUNT_IN_SUMMARY}
    run keyword if    ${EXPECTED_QTY_OF_REJECTED} == ${FINAL_REJECTION_COUNT_IN_SUMMARY}   Validation 5    ELSE IF   ${EXPECTED_QTY_OF_REJECTED} != ${FINAL_REJECTION_COUNT_IN_SUMMARY}   Validation 6
    log   ✅ FINAL Rejection Quantity of Item " ${itemData1}[0] " in summary view (After Rework) = ✅ ${FINAL_REJECTION_COUNT_IN_SUMMARY}

    #    ***********************     FINAL QTY IN DETAILS VIEW    **********************************
#    ${rejecteddetailedQuantity5} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    ${EXPECTED_FINAL_FEJECTED_QTY_IN_DETAILS}  Evaluate  eval("${finalrejectedetailed2Quantity} - 10")
    ${ACTUAL_REJECTED_QTY_IN_DETAILS} =  rejected current quantity of detailed view  ${itemData1}[0]  ${machine}[0]  ${rejection}[1]
    log   ${ACTUAL_REJECTED_QTY_IN_DETAILS}
#    Should Be Equal As Integers    ${EXPECTED_FINAL_FEJECTED_QTY_IN_DETAILS}    ${ACTUAL_REJECTED_QTY_IN_DETAILS}
    log   ${EXPECTED_FINAL_FEJECTED_QTY_IN_DETAILS}
    run keyword if    ${EXPECTED_FINAL_FEJECTED_QTY_IN_DETAILS} == ${ACTUAL_REJECTED_QTY_IN_DETAILS}   Validation 1    ELSE IF   ${EXPECTED_FINAL_FEJECTED_QTY_IN_DETAILS} != ${ACTUAL_REJECTED_QTY_IN_DETAILS}   Validation 2
    log    ✅ FINAL Rejection Quantity of Item " ${itemData1}[0] " in Details view (After Rework) = ✅ ${EXPECTED_FINAL_FEJECTED_QTY_IN_DETAILS}


*** Keywords ***
Validation 1
    log to console   ✅ Rejection Qty in Details view is Accurate
Validation 2
    log to console   ❌ Rejection Qty in Details view is Wrong
Validation 3
    log to console   ✅ Current Qty is Accurate
Validation 4
    log to console   ❌ Current Qty is Wrong
Validation 5
    log to console   ✅ Rejection Qty in Summary view is Accurate
Validation 6
    log to console   ❌ Rejection Qty in Summary view is Wrong



