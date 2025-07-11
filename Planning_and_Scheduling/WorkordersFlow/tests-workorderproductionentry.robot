*** Settings ***
#Library  SeleniumLibrary
Library  String
Library  Collections
Resource  ../../keywords.robot
#Resource  ../variables.robot
Library  DateTime
Resource  ../../orders/salesorder/variables.robot
Resource  ../../orders/salesorder/keywords.robot
Resource  keyword.robot
Resource  variable.robot
Library    BuiltIn
Library    Browser



*** Variables ***
@{customername}  Test01
@{itemData1}  FG-item2  1000  50  20

${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}  Parent machine1
${shift}  Morning
${index}      1
${ROW_SELECTOR}    //tbody[@class="MuiTableBody-root css-1xnox0e"]
${Timesxpath}  //div[@style="text-align: left;"] | //div[@id="scheduling__wo_drawer__timeline__duration"] | //div[@style="text-align: right;"]




*** Test Cases ***

Workorder production entry
    login devsite
    select site  testingautomationsite2
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible  timeout=30s
    #getting rules in the item
    ${time_string}  ${processname}  ${Rulestime}=  Get All rules data  ${itemData1}  ${ROW_SELECTOR}
    click  //button[normalize-space()='Create']
    click  ${createworkorderbutton}
    sleep  1
    ${all_windows}=    Get Page Ids
    Log    ${all_windows}
    Switch Page        ${all_windows[0]}
    Log    Switched to window: ${all_windows[0]}
    Wait For Elements State      //div[text()="${machine}[0]"]   visible  timeout=60s
    click on machine button for workorder or downtime creation  ${machine}[0]  ${itemData1}[2]  ${itemData1}[0]  ${Rulestime}
    #calculation of RUles TImining in hours
    ${total_time} =    Calculate Total Time    ${time_string}    ${itemData1}[2]
    Log    Total time for 100 units: ${total_time}
    click  ${createworkorder}
    I Should See Text On Page        Work Order Created Successfully
    #get all Workorders ID
    ${newly_workorder_id}=    Get All Workorders IDs
    click  //div[@data-task-id="${newly_workorder_id}"]
    ${work_order_number} =    Get Text    id=woText
    Wait For Elements State    //div[text()="${customername}[0]"]/../../..//a[text()="${order_number}"]    visible  timeout=60s
    Wait For Elements State    (//div[text()="${machine}[0]"])[2]/../../../../div[2]//div[text()="${total_time}"]   visible  timeout=60s
#    Wait For Elements State    //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]    visible  timeout=60s
    #In salesorder validaion of workorder
    Switch Page        ${all_windows[2]}
    #salesorder workordercarview validation
    click  //div[@id="item__tabs-tab-5"]
#    Wait For Elements State   //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]   visible  timeout=60s
    Wait For Elements State   //div[text()="${total_time}"]/../../../../..//div[text()="${machine}[0]"]/../..//div[text()="${work_order_number}"]    visible  timeout=60s
    #validation in table view
    click  ${tableviewbutton}
#    Wait For Elements State    //div[text()="${work_order_number}"]/../../td[4][text()="${machine}[0]"]/../td[5]//span[text()="${itemData1}[0]"]/../../../../../../../../../td[6][text()="${processname}"]    visible  timeout=60s
    #scheduling page
    Switch Page        ${all_windows[0]}
    Log    Switched to window: ${all_windows[0]}
    #click on production button
    sleep  1
    Workorder buttons  5  ${work_order_number}
    sleep  1
    ${all_windows}=    Get Page Ids
    Log    ${all_windows}
    Switch Page        ${all_windows[0]}
    # production entry
    Select Option From Dropdown By Inputting    (//input[@id="shift_id"])[1]    ${shift}
#    Wait For Elements State    ${loaderinterval}    visible  timeout=60s
    click    ${intervalDropdown}     #interval dropfown
    sleep  1
    click  ${productionsubmitbutton}
    sleep  1
    #validation of workorder
#    Wait For Elements State    (//span[text()="${machine}[0]"]/../../../../../div[5]//span)[3][text()="${work_order_number}"]
#    Wait For Elements State    (//span[text()="${itemData1}[0]"]/../../../../div[3]//span)[3][text()="/ ${itemData1}[2] piece"]
    #production entry
    set ith item in productionForm only Quantity  0  ${itemData1}[0]  ${itemData1}[3]
    click  ${productionformsubmitbtn}
    I Should See Text On Page        Data saved Successfully
    Switch Page        ${all_windows[3]}
    Reload
    click  //div[@data-task-id="${newly_workorder_id}"]
    #validation of produced quantity
    #wait until element is visible    //span[text()="${itemData1}[0]"]/../../../../../../../../../../tr[3]//td[3]//div[text()="${itemData1}[3]"]
    #validation on salesorder
    Switch Page        ${all_windows[2]}
    Reload
    #wait until element is visible    (//a[text()="${itemData1}[0]"])[1]/../../../../../../../../../td[6]//div[text()="${itemData1}[3] piece"]
    click  //div[@id="item__tabs-tab-5"]
#    Wait For Elements State    //span[text()="${itemData1}[0]"]/../../../../../../../../../../tr[3]//td[3]//div[text()="${itemData1}[3]"]
























