*** Settings ***
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
${expected_text}    Issued
@{inspected_By}   Akash

*** Test Cases ***
Verify Rejection Flow
    set selenium speed    0.05s
    Open Browser Site
    Login To ManufApp Site
#    select site    testingsiteautomation  #Smart Factory
    wait until page contains element    ${INVENTRY}     10s
    mouse over    ${INVENTRY}
    click    ${WAREHOUSES}
    click    ${REFRESH}

    Search Item in Item Details SearchBox   ${ItemData}[1]  1   1   2
    sleep    1s
    ${Current Stock}=   get text    (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[3]
    log to console    ✅ Before Current stock = ${Current Stock}
    log    ✅ Before Current stock = ${Current Stock}
    sleep    0.5s
    click   ${REJECTED}
    sleep   0.5s
    click    ${REFRESH}
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   2   4

    wait until element is visible    ${REJECTION_QTY}
    ${Before_Rejected}=    get text    ${REJECTION_QTY}
    log to console    ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ${Before_Rejected}
    log    ✅ (Before) Rejection Quantity of this Item " ${ItemData}[1] " = ${Before_Rejected}
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
    click    ${APPROVE}
    wait until page contains element    ${MRN_APPROVE_NOTE}
    ${MRN_Note}=    get text    ${MRN_APPROVE_NOTE}
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${WAREHOUSES}
    click    ${REFRESH2}
    click   ${REJECTED}
    sleep   0.5s

    #    search in Summary view
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    wait until element is visible    ${REJECTION_QTY}
    ${After_Rejected}=    get text    /${REJECTION_QTY}
    log    ✅ ${After_Rejected}
    log to console    ✅ (After) Rejection Quantity of this Item " ${ItemData}[1] " = ${After_Rejected}

    #    search in Details view
    click    ${DETAILS_VIEW}
    sleep    2s
    wait until page contains element    ${ITEM_DETAILS_SEARCHBOX}
#    Search item
    Search Item in Item Details SearchBox   ${ItemData}[1]  2   1   3
    click    ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    select partner   @{Vendor}
    click    ${CLICK_PARTNER_SEARCH_ICON2}
    ${Rejection_Reason}=    get text    (//*[@class="ant-table-row ant-table-row-level-0"])[11]//td[8]
    log to console    ✅ Rejection Reason = ${Rejection_Reason}
    log    ✅ Rejection Reason = ${Rejection_Reason}
    Execute JavaScript    window.scrollTo(0, 100)
    ${Rejected_Qty}=    get text    ${REJECTED_QTY}
    log to console     ✅ Rejection Qty = ${Rejected_Qty}
    log    ✅ Rejection Qty = ${Rejected_Qty}





