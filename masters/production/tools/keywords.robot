*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot


*** Variables ***
     #change name here
@{editToolsData}  editLabel19  1  editPart3

*** Keywords ***
open tools page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersTools}

tools should be added
    [Arguments]  ${labelName}
    click  //button[@id='tools__filterBtn']//*[name()='svg']
    sleep  2
    press keys  //input[@id='label']  CTRL+A  BACKSPACE
    sleep  2
    input  //input[@id='label']  ${labelName}
    wait until page contains  ${labelName}


select option
    [Arguments]  ${dropdown}
    wait until page contains element  ${dropdown}  20
    click  ${dropdown}/..
    sleep  2
    press keys  ${dropdown}  ARROW_DOWN  ENTER
    sleep  1
#Set Global Variable
#    [Arguments]    ${variable_name}    ${value}
#    Set Global Variable    ${variable_name}    ${value}

edit tools
    [Arguments]  ${labelName}
    click  //a[text() = "${labelName}"]
    sleep  2
    ${randomnewlabel}=  generate random string  1  [NUMBERS]
    press keys  ${label}  CTRL+A  BACKSPACE  ${randomnewlabel}
    press keys  ${multiplier}  CTRL+A  BACKSPACE  ${editToolsData}[1]
    press keys  ${lifetime}  CTRL+A  BACKSPACE  ${editToolsData}[1]
    press keys  ${partsLabel}  CTRL+A  BACKSPACE  ${editToolsData}[2]
    press keys  ${partsLifetime}  CTRL+A  BACKSPACE  ${editToolsData}[1]
    press keys  ${maintenanceCycle}  CTRL+A  BACKSPACE  ${editToolsData}[1]
    sleep  5
    select option  ${toolCTR}
#    select option  ${machineGroupTags}
#    select option  ${itemGroupTags}
#    select option  ${processTags}
    click  ${Submit}
    i should see text on page  Tool Details Edited Successfully
    open tools page
    reload page
    sleep  2
    tools should be added  ${randomnewlabel}
    click   //a[text() = "${randomnewlabel}"]/../../../../../../../../../../td[7]/div/button[@id = "tools__Deactivate"]
    click  ${deactivate_downtime}
    i should see text on page  Tool deactivated successfully
