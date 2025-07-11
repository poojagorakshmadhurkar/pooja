*** Settings ***
Library    Browser
Library    String
Library    Collections
Library    DateTime
Resource   ../../orders/PurchaseOrder/keyword.robot
Resource   ../../orders/PurchaseOrder/variable.robot
Resource   ../../keywords.robot
Resource   ../../variables.robot
Resource   ./Variable1.robot
Resource   ./Keyword1.robot
Resource   ../../Access_Control/Variable.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}   Newvendortest01
@{ItemData}   0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30   112
${expected_text}   Issued
@{inspected_By}   Akash

*** Test Cases ***
Verify Rejection and Rework Flow After PO Creation & After Performing IQC
    Login To ManufApp Site
    #   select site    testingsiteautomation  #Smart Factory
    Wait For Elements State    ${INVENTRY}   Visible  timeout=60s
    Hover   ${INVENTRY}
    Sleep  4s
    Wait For Load State   domcontentloaded   timeout=30s
    click   ${WAREHOUSES}
    Sleep  4s
    Wait For Load State   domcontentloaded   timeout=30s
    Wait For Elements State   ${REFRESH}  Visible  timeout=30s
    click   ${REFRESH}
    sleep   3s
    #    Search in live inventory
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    #  INITIAL CURRENT QTY
    ${Initial_Current_Stock}=   get text    (//span[text()='${ItemData}[1]'])[1]/../../../../../../../../..//td[3]
    log   ✅ Before Rejection & rework Current stock of this item " ${ItemData}[1] " = ✅ ${Initial_Current_Stock}
    #   Remove unit of current qty
    ${Initial_Current_Stock_qty}  Evaluate  ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) if ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) else '0'
    ${Initial_Current_qty_without_Unit}  Convert To Integer  ${Initial_Current_Stock_qty}
    log   ✅ Initial Qty without unit = ✅ ${Initial_Current_qty_without_Unit}
    click   (//*[@data-testid="CloseOutlinedIcon"])[1]
    click   ${REJECTED}
    #  Search in Rejection
    sleep   2s
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    Wait For Elements State    ${REJECTION_QTY}   Visible  timeout=60s
    ${Before_Rejected}=    get text    ${REJECTION_QTY}
    log   ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ✅ ${Before_Rejected}
    #    Remove unit of current qty of rejection
    ${Initial_Rejection_Qty}  Evaluate  ''.join(c for c in "${Before_Rejected}" if c.isdigit()) if ''.join(c for c in "${Before_Rejected}" if c.isdigit()) else '0'
    ${Initial_Total_Rejection_Qty}  Convert To Integer  ${Initial_Rejection_Qty}
    log   ✅ ${Initial_Total_Rejection_Qty}
    # DOING INWARD REQUEST FROM INVENTORY
    Landing On Purchase Order Page
    # click   ${Approve1}
    sleep   1s
    PO_Inward_Flow_Using_Single_Item
    Hover    ${INVENTRY}
    click    ${TRANSACTIONS}
    click    (//span[text()='IQC Pending'])[1]
    click   ${PERFORM_IQC}
    ${GRN_NO}=  get text    (//div[contains(@class,'MuiGrid-root MuiGrid-item')]//span)[3]
    Wait For Elements State   //*[@id="credit__rejections__edit"]  Visible  timeout=30s
    Click    ${REJECTION_Text}
    click    //*[@id="credit__rejections__edit"]
    Wait For Elements State    ${REJECTION_REASON}  visible  timeout=30s
    Select From Dropdown    ${REJECTION_REASON}    BUBBLES
    input   ${REJECTION_INPUTBOX}    5
    log   ✅ Entered Rejection Qty is = ✅ 5        #${randomrefNumber}
    click    ${SUBMIT3}
    Wait For Elements State    ${TRANSACTION_NOTE}   Visible  timeout=60s
    ${text}=    get text    ${TRANSACTION_NOTE}
    log    ✅ ${text}
    click   ${BACK2}
    click   ${APPROVE}
    Wait For Elements State    ${MRN_APPROVE_NOTE}   Visible  timeout=60s
    ${MRN_Note}=    get text    ${MRN_APPROVE_NOTE}
    #  AFTER REJECTION CURRENT QTY
    Hover    ${INVENTRY}
    Wait For Elements State   ${WAREHOUSES}  Visible  timeout=60s
    click    ${WAREHOUSES}
    Wait For Elements State   ${INVENTRY}  Visible  timeout=60s
    click    ${INVENTRY}
    Reload
    click    ${REFRESH2}
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    Wait For Elements State   ${WAREHOUSES}  Visible  timeout=60s
    ${Current Stock1}=   get text    (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[3]
    log   ✅ ${Current Stock1}
#    Remove unit of rejection qty
    ${Quantity_number1}  Evaluate  ''.join(c for c in "${Current Stock1}" if c.isdigit()) if ''.join(c for c in "${Current Stock1}" if c.isdigit()) else '0'
    ${integer_value1}  Convert To Integer  ${Quantity_number1}
    log   ✅${integer_value1}
    ${Total}    Evaluate   (${Initial_Current_qty_without_Unit} + 150) - 5
    Should Be Equal As Numbers    ${Total}    ${integer_value1}
    run keyword if   ${Total} == ${integer_value1}   Validation 3    ELSE IF   ${Total} != ${integer_value1}   Validation 4
    #  CHECK AFTER REJECTION QTY SUMMARY VIEW
    click   ${REFRESH2}
    Wait For Elements State   ${REJECTED}  Visible  timeout=60s
    click   ${REJECTED}
    Reload
    #    search in Summary view
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    Wait For Elements State    ${REJECTION_QTY}   Visible   timeout=60s
    ${After_Rejected}=    get text    ${REJECTION_QTY}
    log   ✅ (After) Total Rejection Quantity of this Item " ${ItemData}[1] " = ${After_Rejected}
    ${Quantity_number2}  Evaluate  ''.join(c for c in "${After_Rejected}" if c.isdigit()) if ''.join(c for c in "${After_Rejected}" if c.isdigit()) else '0'
    ${integer_value2}  Convert To Integer  ${Quantity_number2}
    log   ✅After Rejection without unit = ✅ ${integer_value2}
    ${Total2}    Evaluate    ${Initial_Total_Rejection_Qty} + 5
    Should Be Equal As Numbers    ${Total2}    ${integer_value2}
    run keyword if    ${Total2} == ${integer_value2}   Validation 5    ELSE IF   ${Total2} != ${integer_value1}   Validation 6
    #   DETAIL VIEW
    click    ${DETAILS_VIEW}
    sleep    2s
    Wait For Elements State    (//*[@id="live_inventory_Item Details_search"])[2]  Visible         timeout=60s
    sleep   1s
    #    search in Details view
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    click   ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    select partner1   ${Vendor}[0]
    click    ${CLICK_PARTNER_SEARCH_ICON2}
    ${Rejection_Reason}=    get text    (//*[@class="ant-table-row ant-table-row-level-0"])[11]//td[8]
    log    ✅ Rejection Reason = ${Rejection_Reason}
    Get Scroll Position    window.scrollTo(0, 200)
    sleep    1s
    ${Rejected_Qty}=    get text    (//*[@class="ant-table-row ant-table-row-level-0"])[11]//td[9]
    log    ✅ Total Rejection Quantity of "${ItemData}[1]" whose partner name is "${Vendor}[0]" and Rejection Reason is "BUBBLES" = ${Rejected_Qty}
    sleep    0.5s
    ${Rejected_Qty2}  Evaluate  ''.join(c for c in "${Rejected_Qty}" if c.isdigit()) if ''.join(c for c in "$${Rejected_Qty}" if c.isdigit()) else '0'
    ${integer_value3}  Convert To Integer  ${Rejected_Qty2}
    log   ✅ After Rejection without unit = ✅ ${integer_value3}
    log   ✅ Total Rejection Quantity of "${ItemData}[1]" whose partner name is "${Vendor}[0]" and Rejection Reason is "BUBBLES" = ✅ ${integer_value3}
    sleep    0.5s
#   REWORK FLOW
    click   ${REWORK}
    input   ${REWORK_INPUTBOX}    4          #${Rej_randomrefNumber}
    click   ${SUBMIT2}
    sleep   1
    ${REWARK_SUCESSFULLY_MSG_NOTE}=     get text    ${REWARK_NOTE_MSG}
    log   ✅ ${REWARK_SUCESSFULLY_MSG_NOTE}
    log    Entered Rework Qty is = ✅ 4      #${Rej_randomrefNumber}
    Hover   ${INVENTRY}
    click   ${TRANSACTIONS}
    click   ${OUTWARD}
    click   ${REFRESH1}
    click   ${CLICK_ON_ROW1}
    Wait For Elements State    ${REWORK_ID_IN_OUTWARD}   Visible   timeout=60s
    ${REWORK_NOTE_ID}=   get text   ${REWORK_ID_IN_OUTWARD}
    log   ✅ ${REWORK_NOTE_ID}
    Wait For Elements State    (//span[text()='${ItemData}[1]'])[1]    Visible  timeout=60s
    Wait For Elements State    ${REJECTION_QTY2}  Visible   timeout=60s
    ${Rejectionn_Qty}=   get text    ${REJECTION_QTY2}
    log   ✅ Validate the Rejection qty from Outword Note popup = ✅ ${Rejectionn_Qty}
    click   ${CANCEL_ICON}
    Search Note in MRN Issue Searchbox     ${REWORK_NOTE_ID}
    Wait For Elements State    (//*[@id="transaction_debit_approve"])[3]    visible  timeout=30s
#    click   ${APPROVE_FOR_DEBIT}
#    ${MRR_NOTE}=    get text    ${MRN_APPROVE_NOTE}
#    log   ✅ ${MRR_NOTE}
#   CALCULATE EXPECTED FINAL QTY AFTER REJECTION AND REWORK
    ${Total3}    Evaluate    ${Total} + 4
    Hover   ${INVENTRY}
    click   ${WAREHOUSES}
    click   ${REFRESH}
    click   ${RAW_MATERIAL}
    Reload
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    ${Current Stock}=   get text    (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[3]
    log   ✅ After rework Current stock of this item " ${ItemData}[1] " = ✅ ${Current Stock}

    ${Final_Current_Stock_qty}  Evaluate  ''.join(c for c in "$${Current Stock}" if c.isdigit()) if ''.join(c for c in "${Current Stock}" if c.isdigit()) else '0'
    ${Final_Current_qty_without_Unit}  Convert To Integer  ${Final_Current_Stock_qty}
    log   ✅ Final Current stock Qty without unit = ✅ ${Final_Current_qty_without_Unit}
    Should Be Equal As Numbers    ${Total3}    ${Final_Current_qty_without_Unit}
    run keyword if    ${Total3} == ${Final_Current_qty_without_Unit}   Validation 3    ELSE IF   ${Total3} != ${Current Stock}   Validation 4

*** Keywords ***
Validation 1
    log to console   ✅ Rework Qty is Accurate
Validation 2
    log to console   ❌ Rework Qty is Wrong
Validation 3
    log to console   ✅ Current Qty is Accurate
Validation 4
    log to console   ❌ Current Qty is Wrong
Validation 5
    log to console   ✅ Rejection Qty is Accurate
Validation 6
    log to console   ❌ Rejection Qty is Wrong


