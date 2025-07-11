*** Settings ***
#Library  SeleniumLibrary
Library  String
Library  Collections
Resource  ../../keywords.robot
#Resource  ../variables.robot
Library  DateTime
#Resource  ../orders/salesorder/variables.robot
Resource  ../../orders/salesorder/keywords.robot
Resource  keyword.robot
Resource  variable.robot
Library    BuiltIn
Library    Browser



*** Variables ***
@{customername}  Test01
@{itemData1}  FG-item2  1000  50
${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}    Parent machine1
${shift}  Morning Shift
${index}      1
${ROW_SELECTOR}    //tbody[@class="MuiTableBody-root css-1xnox0e"]
${Timesxpath}  //div[@style="text-align: left;"] | //div[@id="scheduling__wo_drawer__timeline__duration"] | //div[@style="text-align: right;"]




*** Test Cases ***

Workorder creation
    login devsite
    select site  testingautomationsite2
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    sleep  1
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State          //div[text()="${order_number}"]    visible  timeout=30s
    #getting rules in the item
    sleep  1
    ${time_string}  ${processname}  ${Rulestime}=  Get All rules data  ${itemData1}  ${ROW_SELECTOR}
    click  //button[normalize-space()='Create']
    click  ${createworkorderbutton}
    sleep  1
    ${all_windows}=    Get Page Ids
    Log    ${all_windows}
    Switch Page            ${all_windows[0]}
    Log    Switched to window: ${all_windows[0]}
    Wait For Elements State      //div[text()="${machine}[0]"]   visible  timeout=60s
    click on machine button for workorder or downtime creation  ${machine}[0]  ${itemData1}[2]  ${itemData1}[0]  ${Rulestime}
    #calculation of RUles TImining in hours
    ${total_time} =    Calculate Total Time    ${time_string}    ${itemData1}[2]
    Log    Total time for 100 units: ${total_time}
    click  ${createworkorder}
    I Should See Text On Page        Work Order Created Successfully
    sleep  1
    #get all Workorders ID
    ${newly_workorder_id}=    Get All Workorders IDs
    click  //div[@data-task-id="${newly_workorder_id}"]
    ${work_order_number} =    Get Text    id=woText
    Wait For Elements State        //div[text()="${customername}[0]"]/../../..//a[text()="${order_number}"]  visible  timeout=60s
    sleep  1
    #wait until element is visible    (//div[text()="${machine}[0]"])[2]/../../../../div[2]//div[text()="${total_time}"]
#    Wait For Elements State        //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]  visible  timeout=60s
    #In salesorder validaion of workorder
    Switch page        ${all_windows[2]}
    #salesorder workordercarview validation
    click  //div[@id="item__tabs-tab-5"]
#    Wait For Elements State   //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]/../td[5][text()="${itemData1}[2]"]   visible  timeout=60s
#   Wait For Elements State   //div[text()="${total_time}"]/../../../../..//div[text()="${machine}[0]"]/../..//div[text()="${work_order_number}"]    visible  timeout=60s
    #validation in table view
    click  ${tableviewbutton}
    Wait For Elements State    //div[text()="${work_order_number}"]/../../td[4][text()="${machine}[0]"]/../td[5]//span[text()="${itemData1}[0]"]/../../../../../../../../../td[6][text()="${processname}"]   visible  timeout=60s





















