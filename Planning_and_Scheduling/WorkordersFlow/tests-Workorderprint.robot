*** Settings ***
#Library  SeleniumLibrary
Library  String
Library  Collections
Resource  ../../keywords.robot
#Resource  ../../variables.robot
Library  DateTime
#Resource  ../../orders/salesorder/variables.robot
Resource  ../../orders/salesorder/keywords.robot
Resource  keyword.robot
Resource  variable.robot
Library    BuiltIn
Library  OperatingSystem
Library    Browser



*** Variables ***
@{customername}  Test01
@{itemData1}  FG-item2  1000  50

${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  Parent machine1
${shift}  Morning Shift
${index}      1
${ROW_SELECTOR}    //tbody[@class="MuiTableBody-root css-1xnox0e"]
${Timesxpath}  //div[@style="text-align: left;"] | //div[@id="scheduling__wo_drawer__timeline__duration"] | //div[@style="text-align: right;"]
${DOWNLOAD_PATH}    C:/Users/user/Downloads




*** Test Cases ***

Workorder print
    login devsite
    select site  testingautomationsite2
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible  timeout=30s
    #getting rules in the item
    ${time_string}  ${processname}  ${Rulestime}=  Get All rules data  ${itemData1}  ${ROW_SELECTOR}
    click  //button[normalize-space()='Create']
    click  ${createworkorderbutton}
    sleep   1
    ${all_windows}=    Get Page Ids
    Log    ${all_windows}
    Switch Page        ${all_windows[0]}
    Log    Switched to window: ${all_windows[0]}
    Wait For Elements State      //div[text()="${machine}[0]"]    visible  timeout=30s
    click on machine button for workorder or downtime creation  ${machine}[0]  ${itemData1}[2]  ${itemData1}[0]  ${Rulestime}
    #calculation of RUles TImining in hours
    ${total_time} =    Calculate Total Time    ${time_string}    ${itemData1}[2]
    Log    Total time for 100 units: ${total_time}
    click  ${createworkorder}
    I Should See Text On Page       Work Order Created Successfully
    #get all Workorders ID
    ${newly_workorder_id}=    Get All Workorders IDs
    click  //div[@data-task-id="${newly_workorder_id}"]
    ${work_order_number} =    Get Text    id=woText
    Wait For Elements State   //div[text()="${customername}[0]"]/../../..//a[text()="${order_number}"]  visible    timeout=30s
    Wait For Elements State    (//div[text()="${machine}[0]"])[2]/../../../../div[2]//div[text()="${total_time}"]   visible   timeout=30s
#    Wait For Elements State   //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]
    #click on print button
    Workorder buttons  6  ${work_order_number}
    ${files_before} =    OperatingSystem.List Files In Directory    ${DOWNLOAD_PATH}
    Click    ${printbuttonpdf}
    ${files_after} =    OperatingSystem.List Files In Directory    ${DOWNLOAD_PATH}
    ${new_files} =    Find New File    ${files_before}    ${files_after}
    Log    New files found: ${new_files}
    Should Not Be Empty    ${new_files}  # Check that there are new files



