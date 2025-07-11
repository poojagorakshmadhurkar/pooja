*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
Library    Process
Library   BuiltIn
Resource  ../orders/PurchaseOrder/keyword.robot
Resource  ../orders/PurchaseOrder/variable.robot
Resource  ../Access_Control/Variable.robot
Resource  Keyword.robot
Resource  Variable.robot
Resource  ../keywords.robot
Resource  ../variables.robot
Resource  ../orders/Salesorder/keywords.robot
Resource  ../orders/Salesorder/variables.robot
Resource  ../inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource  ../inventory/Rework_Reuse_Scrap/Variable1.robot
Resource  ../Access_Control/Variable.robot
Resource  ../Access_Control/Keyword.robot
Resource  ../Planning_and_Scheduling/Production_Board/Variable.robot
Resource  ../Planning_and_Scheduling/Production_Board/Keyword.robot
Resource  ../Planning_and_Scheduling/WorkordersFlow/keyword.robot
*** Variables ***
@{customername1}   Nitesh_Customer  Nitesh1
@{itemData1}   MRF-14 8X9    200   50   400
@{itemData2}    Mould_MRF-14 8X9    Cutting_MRF-14 8X9   Print_MRF-14 8X9   Emboss_MRF-14 8X9    Stich_MRF-14 8X9    Assy_MRF-14 8X9   MRF-14 8X9
@{machine}    Moulding-Machine   Cutting-Machine   Printing-Machine   Emboss-Machine   Stiching-Machine   Assembling-Machine    Packaging-Machine
@{shift}    GENERAL   First_Shift   morning
@{process}   MOULDING    CUTTING   PRINTING   EMBOSSING    STICHING    ASSY   PACKING
${REGULAR_BROWSER}    None
${INCOGNITO_BROWSER}  None
@{DT_Reason}   No-Plan  Power Cut
@{Machine}  Work_Order_Machine
*** Test Cases ***
Create_DT_Over_The_WO
    [Documentation]    Automates creation of a Work Order from a Sales Order in ManufApp Site2
    [Setup]   Login To ManufApp Site2
    Select Your Site   2  Main_Automation_Unit  # Site ID for Smart Factory
    Sleep  2s
    ${order_number}   ${randomrefNumber}=    Keyword1.Create_SO   ${customername1}[0]   ${itemData1}[0]
    Log To Console    Sales Order Created: ${order_number}
    Click   //a[normalize-space(text())='${order_number}']
    Wait For Elements State   ${Createe_WO}   visible   timeout=30s
    Click   ${Createe_WO}
    Sleep   2s
    @{Chrome_windows}=    Get Page Ids
    Log To Console    Browser Windows: ${Chrome_windows}
    Switch Page    ${Chrome_windows}[0]   # Switch to new tab
#    Wait For Elements State    ${Show Filters}    visible    timeout=10s
    Click    //div[text()="Cutting-Machine"]/../..//button[@id="create_workorder_0"]
#    Click    ${Show Filters}
    Click   //*[text()="Item"]    # Apply Item filter
    Sleep   0.5s    # Replace with wait if possible
#    Scroll To Element    ${itemData2}[0]    # Scroll to item
#    Click   ${click to create wo}    # Create Work Order
    Click   ${Bulk plann}
    Click   ${Review_Change}
    Click   ${+Create}
    Wait For Elements State    ${WO_creation_Note}    visible    timeout=30s
    ${WO_Note}=    Browser.Get Text    ${WO_creation_Note}
    Log    Work Order Note: ${WO_Note}
    Sleep   5s
    ${WO_ID}=    Get All Workorders IDs
    Log    Work Order ID: ${WO_ID}
    Click    //div[@data-task-id="${WO_ID}"]    # Click Work Order
    Wait For Elements State    (//*[text()="${customername1}[0]"])[2]   visible    timeout=30s
    Wait For Elements State    //*[text()="${order_number}"]   visible    timeout=30s
    Wait For Elements State    (//*[text()="${machine}[1]"])[2]   visible    timeout=30s


    ${WO-num}=   browser.Get Text    //*[@id="woText"]
    log   ✅ ${WO-num}
    ${WO_Start_Time}=   browser.Get Text   (//*[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 MuiGrid-grid-md-4 MuiGrid-grid-lg-3 css-6fiaes"])[1]
    ${WO_End_Time}=   browser.Get Text   (//*[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 MuiGrid-grid-md-4 MuiGrid-grid-lg-3 css-6fiaes"])[2]
    ${WO_Time}=   browser.Get Text   //*[@class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 MuiGrid-grid-md-4 MuiGrid-grid-lg-6 css-p6sum0"]
    log   ✅ ${WO_Start_Time}
    log   ✅ ${WO_Time}
    log   ✅ ${WO_End_Time}
    Sleep   5s
#    Reload
#    Create Downrime
#    [Teardown]    Browser.Close Browser

*** Keywords ***
Create Downrime
    Wait For Elements State  //*[text()="${machine}[1]"]//following::button[@id="create_downtime_0"]   visible  timeout=60s
    Click  //*[text()="${machine}[1]"]//following::button[@id="create_downtime_0"]
    Fill Text  ${Enter_Downtime_Reason}   ${DT_Reason}[1]
#   Sleep  3s
    Wait For Elements State    ${Power Cut}   visible  timeout=30s
    Click  ${Power Cut}
    Click  ${Start_time_Select}
    Click  ${Slect_Current_Date}
    Click  ${Click_OK}
    Click  //*[@class="ant-picker-cell ant-picker-cell-in-view ant-picker-cell-range-start ant-picker-cell-range-start-single ant-picker-cell-today"]
    ${date_format}=   Browser.Get Text   ${Start_time_input}
    ${date_format}=   Strip String    ${date_format}
    Log  format = ✅ ${date_format}
    ${date_obj}=   Convert Date   ${date_format}    date_format=%d-%m-%Y %H:%M
    ${formatted}=   Convert Date   ${date_obj}    result_format=%d %b %Y %H:%M
    ${formatted_time}=    Convert Date    ${date_obj}   %H:%M
    Log To Console  ✅ Date & Time: ${formatted}
    Log To Console  ✅ ${formatted_time}
    Scroll To Element   (//*[text()="18"])[2]
    Click   (//*[text()="18"])[2]
    Scroll To Element   (//*[text()="00"])[2]
    Click   (//*[text()="00"])[2]
    Click   ${Click_OK}
    Click   ${Enter_Date}
    Click   ${Today}
    Click   ${Submit_DT}
    ${DT}=  Browser.Get Text   //div[@style="width: 100%; padding-top: 4px; font-size: 13px; text-align: right;"]
    Log To Console  ✅ ${DT}
    ${text}=   Set Variable   ${DT}
    # Step 1: Split the text to get the part inside parentheses
    ${parts}=   Split String   ${text}    (
    ${temp}=    Set Variable   ${parts}[1]   # Gets "1h 13m)"
    # Step 2: Remove the trailing ")"
    ${duration}=    Replace String    ${temp}    )    ${EMPTY}
    Log To Console  ✅ Duration: ${duration}  # Output: 1h 13m
#    Wait For Elements State    ${Submit_DT}  visible   timeout=30s
#    Click   ${Submit_DT}
    Wait For Elements State    //*[text()="Event Created Successfully"]    visible   timeout=60s
    ${Conformation msg}=  Browser.Get Text    //*[text()="Event Created Successfully"]
    Log   ${Conformation msg}
    Reload    #after clicking search we get the list as per text input in the search box
    Sleep   3s
    Click   //*[@downtime]
    Sleep   3s
    ${Downtime_Name}=   Get Elements    ${DT_Reason}[1]
    ${count}=    Get Length    ${Downtime_Name}
    Log   Number of elements: ${count}
    Scroll To Element    (//*[text()="${DT_Reason}[1]"])[2]
    Log To Console    Machine: ${Machine}
    Wait For Elements State    //*[text()="Downtime ("]  visible   timeout=30s
    Wait For Elements State    (//*[text()="${DT_Reason}[1]"])[2]  visible   timeout=30s
    Wait For Elements State    //*[text()="Machine"]  visible   timeout=30s
    Wait For Elements State    (//*[text()="${Machine}[0]"])[2]  visible   timeout=30s
    Log To Console    ✅ Downtime Created Sucessfully







