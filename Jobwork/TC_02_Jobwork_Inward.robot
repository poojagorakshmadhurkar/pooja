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
Inward_JobWork
    Login To ManufApp Site2
    Select Your Site    7    Main_Automation_Unit
    ${Fist note}=   JOW_Creation    ${ItemData}[0]    ${ItemData}[1]   ${JW_Vendor}
    click   ${Inward1}
    Select from inspected by dropdown PO_inward2   Nitu
    ${GRN_NOO}=   Get Text    ${grn}
    Log  ✅ ${GRN_NOO}
    ${randomrefNumber}=   Generate Random number   4
    input   ${InvoiceNum}   ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_Num}   ${random_string}
    input   ${Deleverd_qty}   4
    click   ${Submit_Btnn}
    Wait For Elements State   ${Inwrd_Note}   visible  timeout=60s
    ${inwardNote}=  get text   ${Inwrd_Note}
    log  ✅ ${inwardNote}
    sleep   0.5s
    Click   ${Issue Status}
    Click   ${Summery View Toggle}
    Wait For Elements State    ${IQC Status}   visible  timeout=60s
    Click   ${PERFORM_IQC}
    Click   ${EDIT}
    Click   ${ALL_OK}
    Wait For Elements State    ${TRANSACTION_NOTE}   visible  timeout=60s
    ${T_Note}=  Get Text    ${TRANSACTION_NOTE}
    Log  ✅ ${T_Note}
    Hover  ${Subcontracting}
    Click  ${TRANSACTIONS}
    Search MRN No   ${Fist note}    1  1  2
    Click   ${Approve icon}
    Wait For Elements State   ${Status text}   visible  timeout=60s
    Sleep   1s
    click   ${Approve Btn}
    click   ${Approvee}
    Wait For Elements State   ${MRN_Approve_Note}   visible  timeout=60s
    ${MRN_note}=   get text   ${MRN_Approve_Note}
    log  ✅ ${MRN_note}
    Click   //*[@class="ant-tag ant-tag-orange"]
    ${Status}=  get text    ${JW_Note_Status}    #Status Partially received
    log  ✅ ${Status}
    Wait For Elements State    (//*[text()="4 kg"])[1]     visible  timeout=60s
    Click  ${CANCELICON}