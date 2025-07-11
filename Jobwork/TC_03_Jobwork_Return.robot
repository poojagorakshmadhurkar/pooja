*** Settings ***
Library    Browser
Library    String
Library    Collections
Library    DateTime
Resource   ./../././Jobwork/Keyword.robot
Resource   ./../././Jobwork/Variable.robot
Resource   ./../././Access_Control/Keyword.robot
Resource   ./../././Access_Control/Variable.robot
Resource   ./../././orders/PurchaseOrder/keyword.robot
Resource   ./../././orders/PurchaseOrder/variable.robot
*** Variables ***
@{ItemData}   FG00004   WIP00001    RM00001
${JW_Vendor}   Nitesh_JW_Subcontractor
*** Test Cases ***
Return_JobWork
    Login To ManufApp Site
    Select Your Site    7    Main_Automation_Unit
    ${randomfNum}=   JOW_Creation   ${ItemData}[0]  ${ItemData}[1]   ${JW_Vendor}
    click   ${Inward1}
    Select from inspected by dropdown PO_inward2   Nitu
    ${randomrefNumber}=   Generate Random number   4
    input   ${InvoiceNum}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_Num}    ${random_string}
    input   ${Deleverd_qty}    ${randomfNum}
    click   ${Submit_Btnn}
    Wait For Elements State   ${Inwrd_Note}  visible  timeout=30s
    ${inwardNote}=  Get Text   ${Inwrd_Note}
    log   ✅ ${inwardNote}
    click   ${Approve1}
    ${SHPMENT_NO}=  get text   ${SHP_No}
    log   ✅ ${SHPMENT_NO}
    Safe Click Element   ${Approve_checkbox}
    click   ${Approvee}
    Wait For Elements State   ${MRN_Approve_Note}  visible  timeout=30s
    ${MRN_note}=    get text    ${MRN_Approve_Note}
    log   ✅ ${MRN_note}
    Wait For Elements State   ${PARTNER SEARCH}  visible  timeout=30s
    Search MRN No   ${SHPMENT_NO}   1  1  2
    Mouse Wheel    500    0
    ${Status}=  get text    ${Trsn_Status}
    log   ✅ ${Status}
    Wait For Elements State   (//*[@id="return"])[1]   30s
    click   (//*[@id="return"])[1]
    input   //*[@class="ant-input"]   5
    click   ${Submit}
    ${NOTE}=    get text    ${MSG_NOTE}
    log   ${NOTE}
    click   ${close_popup}
    Hover    ${INVENTRY}
    Wait For Elements State   ${TRANSACTIONS}  30s
    click    ${TRANSACTIONS}
    click   (//*[@text="Approve"])[1]


