#*** Settings ***
##Library  SeleniumLibrary
#Library  String
#Library  Collections
#Resource  ../../keywords.robot
##Resource  ../variables.robot
#Library  DateTime
##Resource  ../orders/salesorder/variables.robot
##Resource  ../orders/salesorder/keywords.robot
#Resource  keyword.robot
#Resource  variable.robot
#Library    BuiltIn
#Library    Browser
#
#
#
#*** Variables ***
#@{customername}  Test01
#@{itemData1}  FG-item2  1000  50
#${xpath}  //span[contains(@class, 'ant-tree-title')]
#@{machine}    Parent machine1
#${shift}  Morning Shift
#${index}      1
#${ROW_SELECTOR}    //tbody[@class="MuiTableBody-root css-1xnox0e"]
#${Timesxpath}  //div[@style="text-align: left;"] | //div[@id="scheduling__wo_drawer__timeline__duration"] | //div[@style="text-align: right;"]
#${TABLE_XPATH}    //table[@style="min-width: 100%; table-layout: fixed;"]
#${LABEL_XPATH}    ./td[contains(@class, 'machine-label')]
#
#
#
#*** Test Cases ***
#
#Workorder creation
#    login devsite
#    select site  testingautomationsite2
#    open machine page
#    Click All Expand Buttons As They Appear
#    ${machine_labels}=    Get Machine Labels
#    Log    ${machine_labels}
#    Log    First machine label: ${machine_labels}[0]
#    Log    Second machine label: ${machine_labels}[1]
#    Planning and scheduling
#    Wait For Elements State      //div[text()="${machine_labels}[0]"]   visible  timeout=60s
#    Wait For Elements State  //div[text()="${machine_labels}[1]"]   visible  timeout=60s
#    select option from dropdown by inputting  ${machineDropwownscheduling}  ${machine_labels}[2]
#    Wait For Elements State  //div[text()="${machine_labels}[3]"]    visible  timeout=60s
#
##    select option from dropdown by inputting  ${machineDropwownscheduling}  ${machine_labels}[4]
##    wait until element is visible    //div[text()="${machine_labels}[5]"]
##    sleep  1
