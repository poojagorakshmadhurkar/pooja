*** Settings ***
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Library     BuiltIn
Resource    ../../keywords.robot
Resource    ../../variables.robot
Resource    ../../././orders/PurchaseOrder/keyword.robot
Resource    ../../././orders/PurchaseOrder/variable.robot
Resource    ../../././orders/Salesorder/keywords.robot
Resource    ../../././orders/Salesorder/variables.robot
Resource    ../../././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource    ../../././inventory/Rework_Reuse_Scrap/Variable1.robot
Resource    ../../././Access_Control/Variable.robot
Resource    ../../././Access_Control/Keyword.robot
Resource    ../Production_Board/Variable.robot
Resource    ../Production_Board/Keyword.robot

*** Variables ***
@{customername1}   Nitesh_Customer  Nitesh1
@{itemData1}       MRF-14 8X9    500    50
@{itemData2}       Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}         Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}           GENERAL    First_Shift   morning
@{process}         MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING

*** Test Cases ***
Enter Production Workflow
    Set Selenium Speed    0.05s
    Open Browser And Login
    ${order_number}   ${randomrefNumber}=    Create Sales Order And Finalize BOM
    Navigate To Production Board
    Set High Priority For Order    ${order_number}
    Create Work Order And Record Production    ${order_number}    ${randomrefNumber}
    Pause And Resume Production    ${order_number}
    Validate Production Data    ${order_number}    ${randomrefNumber}
*** Keywords ***
Open Browser And Login
    Open Browser    ${DEVURL}   ${BROWSER}    alias=regular
    Maximize Browser Window
    Login To ManufApp Site2
    Select Site    productio_board_unit

Create Sales Order And Finalize BOM
    ${order_number}   ${randomrefNumber}=    Keyword1.Create_SO    ${customername1}[0]    ${itemData1}
    Log To Console    ${order_number}
    Click    //a[normalize-space(text())='${order_number}']
    Sleep    0.5s
    Check And Click Finalize BOM    ${Finalize_BOM}
    [Return]    ${order_number}    ${randomrefNumber}

Navigate To Production Board
    Wait Until Element Is Visible    ${Expand_All_Btn}    30s
    Click    ${Expand_All_Btn}
    Scroll Element Into View    ${Expand_All_Btn2}
    Wait Until Element Is Visible    ${Expand_All_Btn2}    30s
    Click    ${Expand_All_Btn2}
    Mouse Over    ${PLANNING_&_SCHEDULING}
    Click    ${Production_Board}

Set High Priority For Order
    [Arguments]    ${order_number}
    Wait Until Element Is Visible    ${All_Sales_Order}    30s
    Click    ${All_Sales_Order}
    Input    ${By_Sales_Order_SearchBox}    ${order_number}
    Click    ${Production Board2}
    Wait Until Element Is Visible    (//*[@class="ant-select-arrow"])[3]    30s
    Sleep    0.05s
    Safely Click Element    ${Set_Priority}
    Safely Click Element    //*[text()="High"]
    Click    ${Agree}
    Wait Until Element Is Visible    //div[normalize-space(text())='${order_number} set High Priority']    30s
    ${msg}=    Get Text    //div[normalize-space(text())='${order_number} set High Priority']
    Log    ${msg}
    Go Back

Create Work Order And Record Production
    [Arguments]    ${order_number}    ${randomrefNumber}
    Wait Until Element Is Visible    ${Createe_WO}    30s
    Set Selenium Speed    0.5s
    Safely Click Element    ${Createe_WO}
    Sleep    0.5s
    ${Chrome_windows}=    Get Window Handles
    Log    ${Chrome_windows}
    Switch Window    ${Chrome_windows[1]}
    Log    Switched to window: ${Chrome_windows[1]}
    Sleep    0.5s
    Safely Click Element    ${Show Filters}
    Safely Click Element    //*[text()="Item"]
    Scroll Up To Element    ${itemData2}[0]    ${order_number}
    Safely Click Element    ${click to create wo}
    Safely Click Element    ${Bulk plann}
    Safely Click Element    ${Review_Change}
    Safely Click Element    ${+Create}
    Wait Until Element Is Visible    ${WO_creation_Note}    30s
    ${WO_Note}=    Get Text    ${WO_creation_Note}
    Log    ${WO_Note}
    Sleep    0.5s
    ${WO_ID}=    Get All Workorders IDs
    Log    ${WO_ID}
    Click    //div[@data-task-id="${WO_ID}"]
    Wait Until Element Is Visible    (//div[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 css-15j76c0"])[2]    30s
    ${WO_Details}=    Get Text    (//div[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 css-15j76c0"])[2]
    Log    ${WO_Details}
    Wait Until Element Is Visible    //div[text()="${customername1}[0]"]/..//div[2][text()="${randomrefNumber}"]/..//div[3]//a[text()="${order_number}"]    30s
    ${WO_Num}=    Get Text    ${woNo}
    Log    ${WO_Num}
    Supervisor Access   ${Supervisor_Email}   ${Supervisor_Pass}    ${order_number}


Pause And Resume Production
    [Arguments]    ${order_number}
    Click    //button[text()="Pause"]
    Wait Until Element Is Visible    //div[text()="${order_number} has been Paused"]    30s
    ${Notification msg}=    Get Text    //div[text()="${order_number} has been Paused"]
    Log    ${Notification msg}
    Wait Until Element Is Visible    //button[text()="Resume"]
    Element Text Should Be    //button[text()="Resume"]    Resume

Validate Production Data
    [Arguments]    ${order_number}    ${randomrefNumber}
    Switch Window    ${Chrome_windows[1]}
    Sleep    2s
    Open Order Tracker Page
    Search Sonumber In SoListpage For Validation    ${order_number}
    Click    //a[normalize-space(text())='${order_number}']
    Wait Until Element Is Visible    ${Expand_All_Btn}    30s
    Click    ${Expand_All_Btn}
    Scroll Element Into View    ${Expand_All_Btn2}
    Wait Until Element Is Visible    ${Expand_All_Btn2}    30s
    Click    ${Expand_All_Btn2}
    Scroll Element Into View    ${Createe_WO}
    Wait Until Element Is Visible    ${Createe_WO}    30s
    Set Selenium Speed    1s
    Click    ${Createe_WO}
    Switch Window    ${Chrome_windows[1]}
    Safely Click Element    ${Show Filters}
    Safely Click Element    //*[text()="Item"]
    Scroll Up To Element    ${itemData2}[1]    ${order_number}
    Safely Click Element    ${click to create wo}
    Safely Click Element    ${Bulk plann}
    Safely Click Element    ${Review_Change}
    Safely Click Element    ${+Create}
    Wait Until Element Is Visible    ${WO_creation_Note}    30s
    ${WO_Note}=    Get Text    ${WO_creation_Note}
    Log    ${WO_Note}
    Sleep    0.5s
    ${WO_ID}=    Get All Workorders IDs
    Log    ${WO_ID}
    Click    //div[@data-task-id="${WO_ID}"]
    Wait Until Element Is Visible    (//div[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 css-15j76c0"])[2]    30s
    ${WO_Details}=    Get Text    (//div[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 css-15j76c0"])[2]
    Log    ${WO_Details}
    Wait Until Element Is Visible    //div[text()="${customername1}[0]"]/..//div[2][text()="${randomrefNumber}"]/..//div[3]//a[text()="${order_number}"]    30s
    ${WO_Num}=    Get Text    ${woNo}
    Log    ${WO_Num}
