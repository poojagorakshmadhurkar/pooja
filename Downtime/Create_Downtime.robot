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
*** Variables ***
@{DT_Reason}   No-Plan  Power Cut
@{Machine}  Work_Order_Machine

*** Test Cases ***
Create Downrime
    Login To ManufApp Site2
#    select site    productio_board_unit
    click  ${PLANNING_&_SCHEDULING}
    click  ${Scheduling_1}          #${SCHEDULING}
    Click  ${Manuf_Logo}
    Sleep  1s
    Wait For Elements State   ${Create_DT_Machine}   visible  timeout=60s
    Click  ${Create_DT_Machine}
    Fill Text  ${Enter_Downtime_Reason}   ${DT_Reason}[1]
#    Sleep  3s
    Wait For Elements State    ${Power Cut}   visible  timeout=30s
    Click  ${Power Cut}
    Click  ${Start_time_Select}
    Click  ${Slect_Current_Date}
    Click  ${Click_OK}
    Click   //*[@class="ant-picker-cell ant-picker-cell-in-view ant-picker-cell-range-start ant-picker-cell-range-start-single ant-picker-cell-today"]
    ${date_format}=   Get Text   ${Start_time_input}
    ${date_format}=    Strip String    ${date_format}
    Log  format = ✅ ${date_format}
    ${date_obj}=    Convert Date    ${date_format}    date_format=%d-%m-%Y %H:%M
    ${formatted}=    Convert Date    ${date_obj}    result_format=%d %b %Y %H:%M
    ${formatted_time}=    Convert Date    ${date_obj}   %H:%M
    Log To Console  ✅ Date & Time: ${formatted}
    Log To Console  ✅ ${formatted_time}
    Scroll To Element   (//*[text()="18"])[2]
    Click   (//*[text()="18"])[2]
    Scroll To Element    (//*[text()="00"])[2]
    Click   (//*[text()="00"])[2]
    Click   ${Click_OK}
    Click   ${Enter_Date}
    Click   ${Today}
    Click   ${Submit_DT}
    ${DT}=  Browser.Get Text    //div[@style="width: 100%; padding-top: 4px; font-size: 13px; text-align: right;"]
    Log To Console  ✅ ${DT}
    ${text}=    Set Variable    ${DT}
    # Step 1: Split the text to get the part inside parentheses
    ${parts}=    Split String    ${text}    (
    ${temp}=    Set Variable    ${parts}[1]   # Gets "1h 13m)"
    # Step 2: Remove the trailing ")"
    ${duration}=    Replace String    ${temp}    )    ${EMPTY}
    Log To Console  ✅ Duration: ${duration}  # Output: 1h 13m
#    Wait For Elements State    ${Submit_DT}  visible   timeout=30s
#    Click   ${Submit_DT}
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
    Close Browser


    



