*** Settings ***
Library    SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Resource    ../../orders/PurchaseOrder/keyword.robot
Resource    ../../orders/PurchaseOrder/variable.robot
Resource    ../../keywords.robot
Resource    ../../variables.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}   Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
${expected_text}    Issued
@{inspected_By}   Akash

*** Test Cases ***
Verify Rejection Flow
    set selenium speed    0.5s
#    Open Browser Site
#    Login To ManufApp Site
    Open Browser In Headless Mode
#    select site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    PO_Inward_Flow_Using_Single_Item
    mouse over    ${INVENTRY}
    sleep   0.05s
    click   ${TRANSACTIONS}
    click   ${IQC_PENDING1}
    click   ${PERFORM_IQC}
    ${GRN_NO}=  get text    ${GRN_No2_TEXT}
    click    ${EDIT}
    Select From Dropdown    ${REJECTION_REASON}    BUBBLES
    Insert Value    ${REJECTION_INPUTBOX}    5
    click    ${SUBMIT3}
    wait until page contains element    ${TRANSACTION_NOTE}
    ${text}=    get text    ${TRANSACTION_NOTE}
    log    ✅ ${text}
    Sleep   0.5s
    click    ${BACK2}
    click    ${APPROVE}
    wait until page contains element    ${MRN_APPROVE_NOTE}
    ${MRN_Note}=    get text    ${MRN_APPROVE_NOTE}
    mouse over   ${INVENTRY}
    sleep   0.05s
    click   ${WAREHOUSES}
    click   ${REFRESH2}
    click   ${REJECTED}
    sleep   0.5s
    Search Item in Item Details SearchBox   ${ItemData}[1]   2   1   3
#    click   (//*[@id="live_inventory_Item Details_search"])[2]
#    input text  //input[@placeholder='Search Item Details']   ${ItemData}[1]
#    click   (//*[@id="live_inventory_Item Details_search"])[3]
    wait until element is visible    ${REJECTION_QTY}   30s
    ${Rejected_Qty}=    get text    ${REJECTION_QTY}
    log    ✅ ${Rejected_Qty}
    Click   ${REFRESH}
    Safely Click Element   ${DETAILS_VIEW}
    sleep   0.5s
    wait until element is visible    ${ITEM_DETAILS_SEARCHBOX}   30s
    click   ${ITEM_DETAILS_SEARCHBOX}
    input   ${ITEM_DETAILAS_INPUTFIELD}   ${ItemData}[1]
    click   ${ITEM_DETAILS_SEARCH_ICON}
    sleep   2s
    click    ${CLICK_PARTNER_SEARCH_ICON1}
    click   ${CLICK_PARTNER_INPUT_BOX}
    sleep   0.5s
    select partner1   ${Vendor}[0]
    click    ${CLICK_PARTNER_SEARCH_ICON2}
    sleep   1s
    click   (//span[text()='LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK'])[1]/../../../../../../../../..//td[6]//div//div//button[@text="Rework"]
    sleep   2s
    scroll element into view    ${PARTNER_NAME}
    ${randomrefNumber}=   Generate Random number_1_digit
    input text  ${ENTER_REJECTED_QTY}  ${randomrefNumber}
    click   ${REWORK_ALL}
    sleep   1
    click   ${SUBMIT5}






