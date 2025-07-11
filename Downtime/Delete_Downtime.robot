*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
Resource  ../orders/PurchaseOrder/keyword.robot
Resource  ../orders/PurchaseOrder/variable.robot
Resource  ../Access_Control/Variable.robot
Resource  Keyword.robot
Resource  Variable.robot

*** Test Cases ***
Delete Downtime
    Login To ManufApp Site2
    # select site    productio_board_unit
    click  ${PLANNING_&_SCHEDULING}
    click  ${Scheduling_1}
    Click  ${Manuf_Logo}
    Sleep  1s
    Wait For Elements State   ${Create_DT_Machine}   visible  timeout=60s
    Click  ${Create_DT_Machine}
    Fill Text  ${Enter_Downtime_Reason}   NO-PLAN
    Click  ${No_Plann}
    Click  ${Start_time_Select}
    Click  ${Slect_Current_Date}
    Click  ${Click_OK}
    Click  //*[@class="ant-picker-cell ant-picker-cell-in-view ant-picker-cell-range-start ant-picker-cell-range-start-single ant-picker-cell-today"]
    ${date_format}=   Browser.Get Text    ${Start_time_input}
    ${date_format}=   Strip String    ${date_format}  # Remove leading/trailing spaces
    Log To Console  format = ✅ ${date_format}
    ${date_obj}=   Convert Date   ${date_format}    date_format=%d-%m-%Y %H:%M
    ${formatted}=   Convert Date   ${date_obj}    result_format=%d %b %Y %H:%M
    ${formatted_time}=   Convert Date    ${date_obj}   %H:%M
    Log To Console  ✅ Date & Time: ${formatted}
    Log To Console  ✅ ${formatted_time}
    Scroll To Element   (//*[text()="18"])[2]
    Click   (//*[text()="23"])[2]
    Scroll To Element    (//*[text()="00"])[2]
    Click   (//*[text()="00"])[2]
    Click   ${Click_OK}
    Click   ${Enter_Date}
    Click   ${Today}
    ${DT}=  Browser.Get Text    ${Total_DT_Value}
    Log To Console  ✅ ${DT}
    ${text}=   Set Variable   ${DT}
    # Step 1: Split the text to get the part inside parentheses
    ${parts}=  Split String   ${text}    (
    ${temp}=   Set Variable   ${parts}[1]   # Gets "1h 13m)"
    # Step 2: Remove the trailing ")"
    ${duration}=   Replace String    ${temp}   )   ${EMPTY}
    Log To Console  ✅ Duration: ${duration}  # Output: 1h 13m
    Click   ${Submit_DT}
    ${Conformation msg}=  Browser.Get Text   ${DT_Creation_MSG}
    Log   ${Conformation msg}
    Reload
    Sleep   2s
    Click   //*[@downtime]
    Sleep   2s
    ${Downtime_Name}=   Get Elements   ${No_Plann}
    ${count}=    Get Length    ${Downtime_Name}
    Log   Number of elements: ${count}
    Sleep    1s
    Scroll To Element   //span[text()="${formatted_time}"]/../../..//div[1]//button[@aria-label="Delete Downtime"]
    Click   //span[text()="${formatted_time}"]/../../..//div[1]//button[@aria-label="Delete Downtime"]   # //*[@data-testid="DeleteOutlinedIcon"]
    ${Text_A}=   Browser.Get Text   ${Delete_DT_Msg}
    Log   ✅ ${Text_A}
    Log To Console    ✅ Downtime Deleted Successfully
    Close Browser

