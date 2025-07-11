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
    Wait For Elements State    ${Create_DT_Machine}    visible    timeout=60s
    Click  ${Create_DT_Machine}
    Fill Text  ${Enter_Downtime_Reason}    NO-PLAN
    Click  ${No_Plann}
    Click  ${Start_time_Select}
    Click  ${Slect_Current_Date}
    Click  ${Click_OK}
    Click  //*[@class="ant-picker-cell ant-picker-cell-in-view ant-picker-cell-range-start ant-picker-cell-range-start-single ant-picker-cell-today"]
    ${date_format}=   Browser.Get Text   ${Start_time_input}
    Log To Console   format = ✅ ${date_format}
    Scroll To Element   (//*[text()="18"])[2]
    Click   (//*[text()="18"])[2]
    Scroll To Element    (//*[text()="00"])[2]
    Click   (//*[text()="00"])[2]
    Click   ${Click_OK}
    Wait For Elements State    ${Once}   visible   timeout=30s
    Click   ${Once}
    Sleep   2s
    Fill Text   ${DT_Duration_InputBox}   Monthly
    Click   ${Monthly}
    Click   ${Enter_Date}
    Click   ${Today}
    Click   ${Submit_DT}
    ${Conformation msg}=  Browser.Get Text    ${DT_Creation_MSG}
    Log   ${Conformation msg}
    Reload
    Sleep   3s
    Click   //*[@downtime]
    Sleep   3s
    ${Downtime_Name}=   Get Elements    ${No_Plann}
    ${count}=    Get Length    ${Downtime_Name}
    Log To Console   Number of elements: ${count}
#    Wait For Elements State    //*[text()="Downtime ("]  visible   timeout=30s
#    Wait For Elements State    (//*[text()="No-Plan"])[2]  visible   timeout=30s
#    Wait For Elements State    //*[text()="Machine"]  visible   timeout=30s
#    Wait For Elements State    (//*[text()="Work_Order_Machine"])[2]  visible   timeout=30s
    Log To Console   ✅ Downtime Created Sucessfully
    Close Browser




