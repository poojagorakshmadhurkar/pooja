*** Settings ***
Library   Browser
Library  String
Library  Collections
Resource  ./././keyword.robot
Resource  ./././variable.robot
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}   Newvendortest01   Nitesh_Vendor   Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  10   10   101
${expected_text}   Received
@{inspected_By}   Akshay    #Akash     #Testingname    #Afzal   Cindy   Demo Employee


*** Test Cases ***
Verify Orderd Quantity From Inventory(All_OK)
#    Login To ManufApp Site
    # select site    testingsiteautomation
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    ${Actual_Orderd_Qnt.}=  Click_On_Warehouse
    log   ✅ ${Actual_Orderd_Qnt.}
    Landing On Purchase Order Page
    ${PO_No}=    create_po    ${ItemData}  ${vendor}
    click   ${CLICK_PO_DETAILS}
    click   ${CLICK_APPROVE}
    ${Status}   Browser.Get Text    //div[normalize-space(text())='${PO_No} Issued']
    Hover   ${INVENTRY}
    click   ${INWARD_REQUEST}
    Click    //*[@class="header_logo__OwsGs"]
    Select from inspected by dropdown PO_inward2   ${inspected_By}[0]
#    select vendor2  ${Vendor}[0]

    click    //span[text()="Vendor *"]/../../../div[2]
    sleep  1
    Fill Text  ${vendorDrpdwn}  ${Vendor}[0]
    Clear Text    ${vendorDrpdwn}
    Fill Text  ${vendorDrpdwn}   ${Vendor}[0]
    browser.Press Keys   ${vendorDrpdwn}   ArrowDown
    browser.Press Keys   ${vendorDrpdwn}   Enter
    Wait For Elements State    (//span[text() = "${Vendor}[0]"])[2]  visible    timeout=60s

#    input    //*[@id="inward__form__partner"]    ${Vendor}[0]   #Newvendortest01
#    Click    (//span[text()="${Vendor}[0]"])[2]
    Input Into Purchase Order Dropdown PO_inward  ${PO_No}
    ${randomrefNumber}=   Generate Random number   4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
    # selct all item details using checkbox
    Check Checkbox    ${checkbox}
    # select checkbox    (//input[@type="checkbox"])[5]
    click    ${Auto_fill}
    Click    ${submit}
    #Inward note successfully msg text get
    ${inward_note}    Browser.Get Text    ${inward_note_txt}
    sleep   1s
    ${start_index}    Evaluate   "${inward_note}".find("Your request ") + len("Your request ")
    ${end_index}    Evaluate    "${inward_note}".find(" is submitted for Approval!")
    ${inw_note}    Evaluate    "${inward_note}"[${start_index}:${end_index}]
    log   ✅ Inward Note Msg = ✅ ${inw_note}
    Hover   ${INVENTRY}
    click   ${TRANSACTIONS}
    click   ${REFRESH1}
    Wait For Elements State   ${TRANSACTION_STATUS}   visible   timeout=30s
    ${T_StatusB}  Browser.Get Text   ${TRANSACTION_STATUS}
    log  ✅ Before Approved Inward Request Status = ✅ ${T_StatusB}
    # ${Dquantity}   get text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[5]
    Click on Transaction Actions Buttons    ${ACTION_BUTTON}
    click   ${IQC_PENDING1}
    click   ${PERFORM_IQC}
    ${GRN_NO}=  Browser.Get Text    ${GRN_No2_TEXT}
    log    GRN = ✅ ${GRN_NO}
    click   ${EDIT}
    click   ${ALL_OK}
    #  Transaction Note
    ${Transaction_note}=    Browser.Get Text    ${TRANSACTION_NOTE}
    log   ✅ ${Transaction_note}
    #  Get the Status
    Wait For Elements State   ${NO_REJECTION}   visible   timeout=30s
    ${Rejection Status}=    Browser.Get Text    ${NO_REJECTION}
    log    ${Rejection Status}
    click   ${BACK2}
    click   ${APPROVE}
    Wait For Elements State    ${MRN_APPROVE_NOTE}   visible   timeout=30s
    ${MRN_Note}=    Browser.Get Text    ${MRN_APPROVE_NOTE}
    Hover  ${INVENTRY}
    click  ${WAREHOUSES}
    # ${ApprovedNote}  Browser.Get Text    //div[text()='MRN approved SuccesFully']
    ${T_StatusA}  Browser.Get Text    ${TRANSACTION_STATUS}
    log    ✅ After Approved Inward Request Status = ✅ ${T_StatusA}
    ${GRN_No}  Browser.Get Text    ${GRN_No1}
    # log    ✅ ${ApprovedNote}
    log  GRN = ✅ ${GRN_No}
    Landing On Purchase Order Page
    ${Expected_Ordered_Qt.}=     Click_On_Warehouse
    log  ✅ ${Expected_Ordered_Qt.}
    Landing On Purchase Order Page
    Text validation   ${expected_text}
    [Teardown]    Browser.Close Browser
