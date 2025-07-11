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
Bulk_JW_Inward
    Login To ManufApp Site2
    Select Your Site    7    Main_Automation_Unit
    Hover  ${Subcontracting}
    Wait For Elements State   ${TRANSACTIONS}   visible  timeout=60s
    Click   ${TRANSACTIONS}
    Hover   ${Create Request}
    Wait For Elements State   ${Bulk_Inward}   visible  timeout=60s
    Click   ${Bulk_Inward}
    sleep   2s
    Select JW Vendor    ${JW_Vendor}
    Select multiple_Item_For_bulk_Inward    ${ItemData}[0]
    sleep   1s
    click   ${Add}
    sleep   0.5s
    # click   ${Auto_fill}
    Fill Text    //*[@class="ant-input"]    1
    click   ${Review Btn}
    Click   ${Click Arrow}
    ${SHP_Note}=    Get Text   //*[@style="width: 100%; text-wrap: wrap; word-break: break-word;"]
    ${GRN_No}=  Get Text    //*[@class="ant-input ant-input-disabled"]
    Log    ${SHP_Note}
    Log    ${GRN_No}
    Wait For Elements State    //*[text()="${JW_Vendor}"]
    Wait For Elements State    //td[text()="1"]
    # input    //*[@type="search"]    Nitu
    Select From Dropdown    //*[@type="search"]    Nitu
    ${randomrefNumber}=   Generate Random number   4
    input   ${InvoiceNum2}   ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_Num2}   ${random_string}
    Wait For Elements State   //*[text()="${ItemData}[0]"]   visible  timeout=60s
    Wait For Elements State   //*[text()="2 kg"]   visible  timeout=60s
    Click   ${Create inward btn}
    ${text}=  Get Text  //*[@style="text-align: center; font-size: 18px; font-weight: 500;"]
    Log   ${text}
    Click    //*[text()="Go To Jobwork"]
    Hover    ${INVENTORY}
    Click    ${TRANSACTIONS}
    click   //*[@id="transaction_GRN_search"]
    Fill Text    //input[@placeholder='Search GRN']    ${GRN_No}
    click    (//*[@id="transaction_GRN_search"][1])[2]



