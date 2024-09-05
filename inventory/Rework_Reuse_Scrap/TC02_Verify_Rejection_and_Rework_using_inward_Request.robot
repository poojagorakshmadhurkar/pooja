*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Resource   ../../planning/PurchaseOrder/keyword.robot
Resource   ../../keywords.robot
Resource   ../../variables.robot
Resource   ./Variable1.robot
Resource   ./Keyword1.robot
Resource   ../../planning/PurchaseOrder/variable.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}   Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30    #LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK
${expected_text}    Issued
@{inspected_By}   Akash

*** Test Cases ***
Verify the Rejection Flow From Inventory
    set selenium speed    0.05s
    Open Browser Site
    Login To ManufApp Site
#    select site    testingautomationsite2  #Smart Factory
    wait until page contains element    ${INVENTRY}   30s
    #    *****************   INITIAL CURRENT QTY ********************
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    click    ${REFRESH}
    #    Search in live inventory
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    ${Initial_Current_Stock}=   get text    (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[3]
    log   ✅ Before Rejection & rework Current stock of this item " ${ItemData}[1] " = ✅ ${Initial_Current_Stock}
    #    Remove unit of current qty
    ${Initial_Current_Stock_qty}  Evaluate  ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) if ''.join(c for c in "${Initial_Current_Stock}" if c.isdigit()) else '0'
    ${Initial_Current_qty_without_Unit}  Convert To Integer  ${Initial_Current_Stock_qty}
    log   ✅ Initial Qty without unit = ✅ ${Initial_Current_qty_without_Unit}
    #    *************************  INITIAL  REJECTION QTY   ***************************
    click   ${REJECTED}
    click    ${REFRESH}
    #    Search in Rejection
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   2   4
    wait until element is visible    //*[@data-row-key="124581"]//td[5]
    ${Before_Rejected}=    get text    //*[@data-row-key="124581"]//td[5]
    log    ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ✅ ${Before_Rejected}

    ${Initial_Rejection_Qty}  Evaluate  ''.join(c for c in "${Before_Rejected}" if c.isdigit()) if ''.join(c for c in "${Before_Rejected}" if c.isdigit()) else '0'
    ${Initial_Total_Rejection_Qty}  Convert To Integer  ${Initial_Rejection_Qty}
    log   ✅ ${Initial_Total_Rejection_Qty}

    #    ******************    DOING INWARD REQUEST FROM INVENTORY    ******************
    mouse over    ${INVENTRY}
    click    ${INWARD_REQUEST}
    click    ${INVENTRY}
    sleep    1s
    Select from inspected by dropdown PO_inward2    @{inspected_By}
    sleep    0.5s
#    select vendor   ${Vendor}
    click    ${VENDOR_PARTNER}
    input text    ${VENDOR_PARTNER}  ${Vendor}[0]
    click   //div[text()='${Vendor}[0]']
    ${randomrefNumber}=   Generate Random number_4_digit
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
    Select Item Code    ${ItemData}[1]
    ${D_qty_randomNumber}=   Generate Random number_1_digit
#    enter Delevered Qty.
    input   ${ENTER_DELEVERD_QTY}    10  #${D_qty_randomNumber}
    log   ✅ Delevered Qty = ✅ 10    #${D_qty_randomNumber}
    click    ${SUBMIT1}
    sleep    1s
    ${GRN_Note}    Get Text    //div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${GRN_Note}".find("Your request ") + len("Your request ")
    ${end_index}    Evaluate    "${GRN_Note}".find(" is submitted for Approval!")
    ${GRN_No}    Evaluate    "${GRN_Note}"[${start_index}:${end_index}]
    log    ✅ ${GRN_No}
    sleep    0.05s
    ${Approve_Note}=  get text   //div[text()='Your request ${GRN_No} is submitted for Approval!']
    log  ✅ ${Approve_Note}
    click    ${BACK1}
    mouse over    ${INVENTRY}
    click    ${TRANSACTIONS}
    sleep    0.05s
    click    ${GRN_SEARCH}
    sleep    0.05s
    input    ${GRN_SEARCH_INPUT_BOX}   ${GRN_No}
    click    ${GRN_SEARCH_INPUT_BOX2}
    click    ${REFRESH1}
    sleep    0.05s
    wait until element is visible    //a[contains(text(),'${GRN_No}')]/../../../..//td[10]   30s
    click    //a[contains(text(),'${GRN_No}')]/../../../..//td[10]
    click   ${PERFORM_IQC}
    ${GRN_NO}=  get text    ${GRN_No2_TEXT}
    click    ${EDIT}
    sleep    0.5s
    Select From Dropdown    ${REJECTION_REASON}   BUBBLES
    input   ${REJECTION_INPUTBOX}    5     #${Rej_Qty_randomNumber}
    log   ✅ Entered Rejection Qty is = ✅ 5      #${Rej_Qty_randomNumber}
    click    ${SUBMIT3}
    wait until page contains element    ${TRANSACTION_NOTE}
    ${text}=    get text    ${TRANSACTION_NOTE}
    log  ✅ ${text}
    click    ${BACK2}
#    reload page
    sleep    0.5s
    click   ${GRN_SEARCH}
    sleep   1s
    input    ${GRN_SEARCH_INPUT_BOX}   ${GRN_No}
    click    ${GRN_SEARCH_INPUT_BOX2}
    sleep   1s
    wait until page contains element   ${APPROVE}  30s
    sleep   1s
    click   ${APPROVE}
    wait until page contains element    ${MRN_APPROVE_NOTE}
    ${MRN_Note}=    get text    ${MRN_APPROVE_NOTE}
    #    ************************   AFTER REJECTION CURRENT QTY   **********************
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${WAREHOUSES}
    sleep   2s
    click    ${INVENTRY}
    click    ${REFRESH2}
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    ${Current Stock1}=   get text    (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[3]
    log    ✅ ${Current Stock1}
#    Remove unit of rejection qty
    ${Quantity_number1}  Evaluate  ''.join(c for c in "${Current Stock1}" if c.isdigit()) if ''.join(c for c in "${Current Stock1}" if c.isdigit()) else '0'
    ${integer_value1}  Convert To Integer  ${Quantity_number1}
    log    ✅${integer_value1}

    ${Total}    Evaluate    (${Initial_Current_qty_without_Unit} + 10) - 5
    Should Be Equal As Numbers    ${Total}    ${integer_value1}
    run keyword if    ${Total} == ${integer_value1}   Validation 3    ELSE IF   ${Total} != ${integer_value1}   Validation 4
    #    ****************   CHECK AFTER REJECTION QTY SUMMARY VIEW   *******************
    click    ${REFRESH2}
    sleep    0.5s
    click   ${REJECTED}
    #   search in Summary view
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   2   4
    wait until element is visible    ${REJECTION_QTY}   30s
    ${After_Rejected}=    get text    ${REJECTION_QTY}
    log  ✅ ${After_Rejected}
    log  ✅ (After) Total Rejection Quantity of this Item " ${ItemData}[1] " = ${After_Rejected}

    ${Quantity_number2}  Evaluate  ''.join(c for c in "${After_Rejected}" if c.isdigit()) if ''.join(c for c in "${After_Rejected}" if c.isdigit()) else '0'
    ${integer_value2}  Convert To Integer  ${Quantity_number2}
    log   ✅After Rejection without unit = ✅ ${integer_value2}

    ${Total2}    Evaluate    ${Initial_Total_Rejection_Qty} + 5
    Should Be Equal As Numbers    ${Total2}    ${integer_value2}
    run keyword if    ${Total2} == ${integer_value2}   Validation 5    ELSE IF   ${Total2} != ${integer_value1}   Validation 6

    #    ****************************   DETAIL VIEW   ***************************
    #    search in Details view
    click    ${DETAILS_VIEW}
    click    ${REFRESH2}
    wait until page contains element    ${ITEM_DETAILS_SEARCHBOX}
#    Search item
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    click   ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    select partner1   ${Vendor}[0]
    click   ${CLICK_PARTNER_SEARCH_ICON2}
    ${Rejection_Reason}=    get text    (//*[@class="ant-table-row ant-table-row-level-0"])[11]//td[8]
    log  ✅ Rejection Reason = ${Rejection_Reason}
    Execute JavaScript    window.scrollTo(0, 100)
    ${Rejected_Qty}=    get text    (//*[@class="ant-table-row ant-table-row-level-0"])[11]//td[9]
    log to console  ✅ Rejection Qty = ${Rejected_Qty}
    log  ✅ Total Rejection Quantity of "${ItemData}[1]" whose partner name is "${Vendor}[0]" and Rejection Reason is "BUBBLES" = ✅ ${Rejected_Qty}
    sleep    0.5s
    ${Rejected_Qty2}  Evaluate  ''.join(c for c in "${Rejected_Qty}" if c.isdigit()) if ''.join(c for c in "$${Rejected_Qty}" if c.isdigit()) else '0'
    ${integer_value3}  Convert To Integer  ${Rejected_Qty2}
    log   ✅ After Rejection without unit = ✅ ${integer_value3}
    log   ✅ Total Rejection Quantity of "${ItemData}[1]" whose partner name is "${Vendor}[0]" and Rejection Reason is "BUBBLES" = ✅ ${integer_value3}
    sleep    0.5s
    click    ${REWORK}
#    ${Rej_randomrefNumber}=   Generate Random number_1_digit
    input   ${REWORK_INPUTBOX}    4
    click   ${SUBMIT2}
    sleep   1
    ${REWARK_SUCESSFULLY_MSG_NOTE}=     get text    ${REWARK_NOTE_MSG}
    log   ✅ ${REWARK_SUCESSFULLY_MSG_NOTE}
    log    Entered Rework Qty is = ✅ 4
    mouse over    ${INVENTRY}
    click   ${TRANSACTIONS}
    click   ${OUTWARD}
    click   ${REFRESH1}
    click   ${CLICK_ON_ROW}
    sleep    1s
     ${REWORK_NOTE_ID}=   get text   ${REWORK_ID_IN_OUTWARD}
    log   ✅ ${REWORK_NOTE_ID}
    sleep    1s
    wait until page contains element    (//span[text()='${ItemData}[1]'])[1]    30s
    wait until page contains element    ${REJECTION_QTY2}  30S
    ${Rejectionn_Qty}=   get text    ${REJECTION_QTY2}
    log   ✅ Validate the Rejection qty from Outword Note popup = ✅ ${Rejectionn_Qty}
    click   ${CANCEL_ICON}
    Search Note in MRN Issue Searchbox     ${REWORK_NOTE_ID}
    wait until page contains element    (//*[@id="transaction_debit_approve"])[3]
    click   ${APPROVE_FOR_DEBIT}
    sleep   1s
    ${MRR_NOTE}=    get text    ${MRN_APPROVE_NOTE}
    log   ✅ ${MRR_NOTE}
    #   CALCULATE EXPECTED FINAL QTY AFTER REJECTION AND REWORK
    ${Total3}    Evaluate    ${Total} + 4
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    click    ${REFRESH}
    sleep    1s
    click    ${RAW_MATERIAL}
    reload page
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    ${Current Stock}=   get text    (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[3]
    log   ✅ After rework Current stock of this item " ${ItemData}[1] " = ✅ ${Current Stock}}

    ${Final_Current_Stock_qty}  Evaluate  ''.join(c for c in "$${Current Stock}" if c.isdigit()) if ''.join(c for c in "${Current Stock}" if c.isdigit()) else '0'
    ${Final_Current_qty_without_Unit}  Convert To Integer  ${Final_Current_Stock_qty}
    log   ✅ Initial Qty without unit = ✅ ${Final_Current_qty_without_Unit}
    Should Be Equal As Numbers    ${Total3}    ${Final_Current_qty_without_Unit}
    run keyword if    ${Total3} == ${Final_Current_qty_without_Unit}   Validation 3    ELSE IF   ${Total3} != ${Current Stock}   Validation 4
    #    *******************************************************
    mouse over    ${INVENTRY}
    click    ${TRANSACTIONS}
    click    ${OUTWARD}
    click    ${CLICK_ON_ROW}
    sleep    1s
    wait until page contains element    (//span[text()='${ItemData}[1]'])[1]    10s
    wait until element is visible    ${REJECTION_QTY2}    30S
    ${Rejectionn_Qty}=   get text    ${REJECTION_QTY2}
    log   ✅ Validate the Rejection qty from Outword Note popup = ✅ ${Rejectionn_Qty}

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


