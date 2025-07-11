*** Settings ***
Library   Browser
Library   BuiltIn
Library   String
Library   Collections
Resource  ./keyword.robot
Resource  ./variable.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Nitesh_Vendor
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30    290
@{ItemData2}  0  CR00015  20   10     #LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK
@{inspected_By}   Testingname   Amar   Cindy   Demo Employee
*** Test Cases ***
PO_Creation
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Sleep    2s
    ${Actual_Orderd_Qnt.}=  Click_On_Warehouse
    Sleep    2s
    Landing On Purchase Order Page
    ${order_number}=    PO_Creation   ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]   ${ItemData}[4]   ${Vendor}[1]
    click   ${CLICK_PO_DETAILS}
    click   ${CLICK_APPROVE}
    PO_Inward   ${order_number}    ${ItemData}[2]
    Log     ✅ PO Creation - Done
    [Teardown]    Browser.Close Browser

#PO_Rejection
#    Login To ManufApp Site
#    ${Actual_Orderd_Qnt.}=  Click_On_Warehouse
#    Landing On Purchase Order Page
#    ${order_number}=    PO_Creation   ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]   ${ItemData}[4]  ${Vendor}[1]
#    click   ${CLICK_PO_DETAILS}
#    click   ${REJECT}
#    Safely Click Element    ${PO_WITHDRAW}
#    Log     ✅ PO Withdraw - Done
#PO_Inspection Report
#    Login To ManufApp Site
#    Landing On Purchase Order Page
#    ${order_number}=    PO_Creation    ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]   ${ItemData}[4]  ${Vendor}[1]
#    click   ${PO_Approved}
#    PO_Inward   ${order_number}    ${ItemData2}[2]
#    Hover    ${INVENTRY}
#    click    ${TRANSACTIONS}
#    click    ${REFRESH1}
#    sleep   1s
#    Wait For Elements State    ${TRANSACTION_STATUS}    visible    timeout=10s
#    ${T_StatusB}=   Browser.Get Text    ${TRANSACTION_STATUS}
#    log    ✅ Before Approved Inward Request Status = ✅ ${T_StatusB}
##    ${Dquantity}   Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[5]
#    Click on Transaction Actions Buttons    ${ACTION_BUTTON}
#    click    ${IQC_PENDING1}
#    click   ${PERFORM_IQC}
#    ${GRN_NO}=  Browser.Get Text    ${GRN_No2_TEXT}
#    log    GRN = ✅ ${GRN_NO}
#    Safely Click Element   ${INSPECTION REPORT}
#    Safely Click Element    //button[@id="__edit"]
#    Wait For Elements State   ${INPUT_INSPECTION VALUE}   visible    timeout=10s
#    input   ${INPUT_INSPECTION VALUE}   14
#    Wait For Elements State    //span[text()="Accepted"]    visible    timeout=10s
#    i should see text on page    //span[text()="Accepted"]
#    Safely Click Element   ${SUBMIT1}
#    Wait For Elements State   //div[normalize-space(text())='Transaction Edited SuccesFully']   visible    timeout=10s
#    ${note}=  Browser.Get Text    //div[normalize-space(text())='Transaction Edited SuccesFully']
#    log     ${note}
#    click   ${BACK2}
#    Hover    ${INVENTRY}
#    sleep    0.05s
#    click    //a[contains(text(),'Transactions')]
#    click    //*[@id="transaction_refresh_icon"]
##    Note:   ${T_Status2} means (Transaction status2)
##    Note:   ${T_Status1} means (Transaction status1)
#    ${T_Status2}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
#    log    ✅ Before Approved Inward Request Status = ✅ ${T_Status2}
#    Click on Transaction Actions Buttons    //*[@id="transaction_credit_approve"]
#    Wait For Elements State   //div[text()='MRN approved SuccesFully']    visible    timeout=10s
#    ${ApprovedNote}  Browser.Get Text    //div[text()='MRN approved SuccesFully']
#    ${T_Status1}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
#    log    ✅ After Approved Inward Request Status = ✅ ${T_Status1}
#    ${GRN_No}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
#    log    ✅ ${ApprovedNote}
#    log    GRN = ✅ ${GRN_No}
#    Landing On Purchase Order Page
#    click   (//*[@id="purchase_order_details"])[1]
#    log    Orderd Quantity = ✅ ${ItemData}[2] pallet
#    log    Delivered Quantity = ✅ ${ItemData}[2] pallet

*** Keywords ***
PO_Creation
    [Arguments]   ${i}  ${item}   ${qty}    ${price}   ${hsn_code}  ${vendor}
    sleep   1.5s
    click    ${CREATE_NEW_BUTTON}
    Select Vendor for PO  ${vendor}
    select Delivery Date
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    Fill Text    //*[@id="purchase_order_remarks"]    Normal
    Select From Dropdown    (//*[@class="ant-select-selection-search-input"])[3]   Plant 2
    set ith item in PO  ${i}  ${item}  ${qty}  ${price}   ${hsn_code}
#   Select Item Code    PR_PR_ORANGE_19
    click   ${SUBMIT}
    log to console   PO creation Successfully done
#    Verify Text
    ${order_info}    Browser.Get Text   xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}   Evaluate   "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}   Evaluate   "${order_info}"[${start_index}:${end_index}]
    click    ${BACK}
#    sleep    0.5s
    Search In PO    ${order_number}
    Wait For Elements State   ${CLICK_PO_DETAILS}   visible    timeout=10s
#    click   ${CLICK_PO_DETAILS}
#    click   ${CLICK_APPROVE}
#    PO_Inward   ${order_number}
#    RETURN   ${order_number}
    RETURN   ${order_number}
Print Item Details In Warehouse
    # Wait until the table is visible
    Wait For Elements State    //div[@class="ant-table-container"]    visible    timeout=10s
    # Get all headers
    @{headers}=    Get Elements    //thead[@class="ant-table-thead"]
    # Get the first row of data
    @{data}=    Get Elements    //div[@class="ant-table-body"]
    # Get the length of the headers list
    ${header_length}=    Get Length    ${headers}
    # Print Item data
    Log    Printing Item Details
    FOR    ${i}    IN RANGE    0    ${header_length}
        ${header_text}=    Browser.Get Text    ${headers}[${i}]
        ${data_text}=    Browser.Get Text    ${data}[${i}]
        log to console  ${header_text}: ${data_text}
        Log    ${header_text}: ${data_text}
    END
PO_Inward
    [Arguments]    ${order_number}  ${Qty}
    sleep   0.05s
    Wait For Elements State   ${inward_button}   visible    timeout=10s        #${inward_button}[1]   10s
    i should see text on page   ${inward_button}
    i should see text on page   ${inward_button}
    click   ${inward_button}
    Wait For Elements State   //span[text()='Inward Against ${order_number} / ${vendor}[1]']  visible    timeout=10s
    ${text}=    Browser.Get Text    //span[text()='Inward Against ${order_number} / ${vendor}[1]']
    log to console    ✅ ${text}
    log   ✅ ${text}
    sleep    0.05s
    should contain    ${text}   ${order_number} / ${vendor}[1]
    Select from inspected by dropdown PO_inward   ${inspected_By}[1]
    ${randomrefNumber}=   Generate Random number    4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
#   selct all item details using checkbox
    Check Checkbox    ${checkbox}
    click    ${Auto_fill}
    Wait For Elements State   //input[@value='${Qty}']  visible    timeout=10s
    log    ✅Entered Quantity = ${Qty}
    sleep    0.05s
    Click    ${submit}
#    sleep    1s
    Wait For Elements State   ${inward_note_msg}  visible    timeout=10s
    ${inward_note}  Browser.Get Text  ${inward_note_msg}
    log   ✅ ${inward_note}
    sleep    0.05s

