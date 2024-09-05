*** Settings ***
Library    SeleniumLibrary
Library  String
Library  Collections
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  10   10
${expected_text}   Issued
@{inspected_By}   Akash   #Afzal   Cindy   Demo Employee


*** Test Cases ***
Verify Orderd Quantity From Inventory(All_OK)
    Open Browser Site
    Login To ManufApp Site
#    select site    testingsiteautomation
    Landing On Purchase Order Page
    ${Actual_Orderd_Qnt.}=  Click_On_Warehouse
    Landing On Purchase Order Page
    ${PO_No}=     create_po    ${ItemData}  ${vendor}   ${date}
    mouse over    ${INVENTRY}
    click   ${INWARD_REQUEST}
    set selenium speed    0.05s
    Select from inspected by dropdown PO_inward2   ${inspected_By}[0]
    Input Into Purchase Order Dropdown PO_inward  ${PO_No}
    ${randomrefNumber}=   Generate Random number_4_digit
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
#   selct all item details using checkbox
    select checkbox    ${checkbox}
#   select checkbox    (//input[@type="checkbox"])[5]
    click    ${Auto_fill}
    click button    ${submit}
    sleep   1s
    #Inward note successfully msg text get
    ${inward_note}    Get Text    ${inward_note_txt}
    ${start_index}    Evaluate    "${inward_note}".find("Your request ") + len("Your request ")
    ${end_index}    Evaluate    "${inward_note}".find(" is submitted for Approval!")
    ${inw_note}    Evaluate    "${inward_note}"[${start_index}:${end_index}]
    log   ✅ Inward Note Msg = ✅ ${inw_note}
    mouse over    ${INVENTRY}
    click    ${TRANSACTIONS}
    click    ${REFRESH1}
    ${T_StatusB}  get text    ${TRANSACTION_STATUS}
    log    ✅ Before Approved Inward Request Status = ✅ ${T_StatusB}
#    ${Dquantity}   get text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[5]
    Click on Transaction Actions Buttons    ${ACTION_BUTTON}
    click    ${IQC_PENDING1}
    click   ${PERFORM_IQC}
    ${GRN_NO}=  get text    ${GRN_No2_TEXT}
    log    GRN = ✅ ${GRN_NO}
    click    ${EDIT}
    click    ${ALL_OK}
    sleep    1s
#    Transaction Note
    ${Transaction_note}=    get text    ${TRANSACTION_NOTE}
    log    ✅ ${Transaction_note}
#    Get the Status
    ${Rejection Status}=    get text    ${NO_REJECTION}
    log    ${Rejection Status}
    click    ${BACK2}
    click    ${APPROVE}
    wait until page contains element    ${MRN_APPROVE_NOTE}
    ${MRN_Note}=    get text    ${MRN_APPROVE_NOTE}
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${WAREHOUSES}
    sleep    0.5s
#    ${ApprovedNote}  get text    //div[text()='MRN approved SuccesFully']
    ${T_StatusA}  get text    ${TRANSACTION_STATUS}
    log    ✅ After Approved Inward Request Status = ✅ ${T_StatusA}
    ${GRN_No}  get text    ${GRN_No1}
#    log    ✅ ${ApprovedNote}
    log    GRN = ✅ ${GRN_No}
    sleep    0.05s
    Landing On Purchase Order Page
    ${Expected_Ordered_Qt.}=     Click_On_Warehouse
    sleep    1s
    Landing On Purchase Order Page
    Text validation   ${expected_text}
    set selenium speed    0.5s
    mouse over    ${INVENTRY}
    sleep    0.05s
    click    ${TRANSACTIONS}
