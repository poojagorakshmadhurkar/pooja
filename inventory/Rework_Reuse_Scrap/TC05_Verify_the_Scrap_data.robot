*** Settings ***
Library    SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Resource    ../../orders/PurchaseOrder/keyword.robot
Resource    ../../orders/PurchaseOrder/variable.robot
Resource    ../../keywords.robot
Resource    ../../variables.robot
Resource   ./Variable1.robot

*** Variables ***
@{item}  Scrap Item-2
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
${expected_text}    Issued
@{inspected_By}   Akash

*** Test Cases ***
Verify Scrap Flow
    set selenium speed    0.05s
#    Open Browser Site
#    Login To ManufApp Site
    Open Browser In Headless Mode
#    select site    testingsiteautomation  #Smart Factory
    wait until page contains element    ${INVENTRY}     10s
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    click    ${REFRESH}
#    //get qty from RM
    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    ${Current Stock}=   get text   ${CURRENT_QTYY}
    log to console    ✅ Before Current stock = ${Current Stock}
    log    ✅ Before Current stock = ${Current Stock}
    sleep    0.5s
    reload page
    click   ${REFRESH}
    click   ${CLICK_ON_SCRAP}    #scrap
    Search Item in Item Details SearchBox   ${item}[0]   2   1   3
#    click   (//*[@id="live_inventory_Item Details_search"])[2]
#    wait until element is visible    //*[@placeholder="Search Item Details"]    20s
#    input text   //*[@placeholder="Search Item Details"]   ${item}[0]
#    click   (//*[@id="live_inventory_Item Details_search"])[3]

    ${ScrpQTY}=     get text   ${GET_SCRAP_QTY}   #scrap qty
    ${Scrap_Qty2}  Evaluate  ''.join(c for c in "${ScrpQTY}" if c.isdigit()) if ''.join(c for c in "${ScrpQTY}" if c.isdigit()) else '0'
    ${Initial_Scrap_integer_value3}  Convert To Integer  ${Scrap_Qty2}
    log   ${Initial_Scrap_integer_value3}
    sleep   0.05s
    click   ${REJECTED}
    sleep   0.5s
    click    ${REFRESH}
#    //search qty in rejected
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   2   5
    wait until element is visible    ${REJECTION_QTYY}    #${REJECTION_QTY}
    ${Before_Rejected}=    get text    ${REJECTION_QTYY}   #${REJECTION_QTY}
    log to console    ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ${Before_Rejected}
    log    ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ${Before_Rejected}
#    //search in scrap
    Landing On Purchase Order Page
    PO_Inward_Flow_Using_Single_Item
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${TRANSACTIONS}
    click    ${IQC_PENDING1}
    click   ${PERFORM_IQC}
    ${GRN_NO}=  get text    ${GRN_No2_TEXT}
    click    ${EDIT}
    Select From Dropdown    ${REJECTION_REASON}    BUBBLES
    Insert Value    ${REJECTION_INPUTBOX}   5
    click    ${SUBMIT3}
    wait until page contains element    ${TRANSACTION_NOTE}
    ${text}=    get text    ${TRANSACTION_NOTE}
    log    ✅ ${text}
    click    ${BACK2}
    sleep   1s
    click    ${APPROVE}
    wait until page contains element    ${MRN_APPROVE_NOTE}
    ${MRN_Note}=    get text    ${MRN_APPROVE_NOTE}
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${WAREHOUSES}
    click    ${REFRESH}
    click   ${REJECTED}
    sleep   0.5s
    click   ${REFRESH}
    #    search in Summary view
    sleep   1s
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    wait until element is visible    ${REJECTION_QTYY}     #${REJECTION_QTY}
    ${After_Rejected}=    get text   ${REJECTION_QTYY}     #${REJECTION_QTY}
    log    ✅ ${After_Rejected}
    log to console    ✅ (After) Rejection Quantity of this Item " ${ItemData}[1] " = ${After_Rejected}
    #    search in Details view
    click    ${DETAILS_VIEW}
    sleep    2s
    wait until page contains element    ${ITEM_DETAILS_SEARCHBOX}
#    Search item
    sleep   0.5s
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    sleep   0.05s
    click    ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    select partner1   ${Vendor}[0]
    click    ${CLICK_PARTNER_SEARCH_ICON2}
    ${Rejection_Reason}=    get text    ${GET_REJECTION_REASON}
    log to console    ✅ Rejection Reason = ${Rejection_Reason}
    log    ✅ Rejection Reason = ${Rejection_Reason}
    Execute JavaScript    ${SCROLL}
    ${Rejected_Qty}=    get text    ${GET_REJECTION_VALUE}
    log to console     ✅ Rejection Qty = ${Rejected_Qty}
    log    ✅ Rejection Qty = ${Rejected_Qty}
    click   ${CLICK_SCRAP_BUTTON}    #scrap buttoN
    sleep   1s
    click   ${CLICK_SCRAPALL_BUTTON}   #SCRAp All button
    input   ${INPUT_ITEM_NAME_FOR_SCRAP}   Scrap Item-1      #input item name
    click   ${SELECT_SCRAP_ITEM}       #select item
    click   ${CLICK_QTY_FIELD}    #click on qty field
    input   ${CLICK_QTY_FIELD}    2
    sleep   1s
#    wait until element is visible    ${SUBMIT3}    20s
    click button    ${CLICK_SUBMIT}      #click submit
    sleep   1s
    ${Scrap_note}=   get text   ${SCRAP_NOTE_MSG}
    log   ${Scrap_note}
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${TRANSACTIONS}
    sleep   1s
    click   ${VALIDATION_FROM_POPUP}     #validation
    wait until page contains element    ${VALIDATE_SCRAP_VALUE}     #validation
    sleep   0.5s
    click   ${CANCELL}
    mouse over    ${INVENTRY}
    sleep   0.05s
    click   ${WAREHOUSES}
    click   ${REFRESH}
    click   ${CLICK_ON_SCRAP}    #scrap
    sleep   1s
    ${Total_Final_Scrap_Value}    Evaluate    ${Initial_Scrap_integer_value3} + 2
    log   ✅ ${Total_Final_Scrap_Value}
    Search Item in Item Details SearchBox   ${item}[0]   2   1   3
    ${Final_ScrpQTY}=     get text    ${GET_SCRAP_QTY}  #scrap qty
    log   ${Final_ScrpQTY}
    ${Final_Current_Scrap_qty}  Evaluate  ''.join(c for c in "${Final_ScrpQTY}" if c.isdigit()) if ''.join(c for c in "${Final_ScrpQTY}" if c.isdigit()) else '0'
    ${Final_Current_Scrap_qty_without_Unit}  Convert To Integer  ${Final_Current_Scrap_qty}
    log   ✅ Final Scrap Qty without unit = ✅ ${Final_Current_Scrap_qty_without_Unit}
    Should Be Equal As Numbers    ${Total_Final_Scrap_Value}    ${Final_Current_Scrap_qty_without_Unit}
    run keyword if    ${Total_Final_Scrap_Value} == ${Final_Current_Scrap_qty_without_Unit}   Validation 1    ELSE IF   ${Total_Final_Scrap_Value} != ${Final_Current_Scrap_qty_without_Unit}   Validation 2
    #    *******************************************************





#    //a[@id="undefined_label"]/../../../../../../../../../../..//td[text()="1 g"]


*** Keywords ***
Validation 1
    log to console   ✅ Scrap Qty is Accurate
Validation 2
    log to console   ❌ Scrap Qty is Wrong
Validation 3
    log to console   ✅ Current Qty is Accurate
Validation 4
    log to console   ❌ Current Qty is Wrong
Validation 5
    log to console   ✅ Rejection Qty is Accurate
Validation 6
    log to console   ❌ Rejection Qty is Wrong
