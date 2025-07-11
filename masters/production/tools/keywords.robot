*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library    Browser


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
    click  (//*[name()='svg'][@id='undefined_Label_search'])[1]
    Click   //input[@placeholder='Search Label']
    input  //input[@placeholder='Search Label']  ${labelName}
    click  (//*[name()='svg'][@id='undefined_Label_search'])[1]
    Wait For Elements State    //a[text() = "${labelName}"]


select option
    [Arguments]  ${dropdown}
    wait until page contains element  ${dropdown}  20
    click  ${dropdown}/..
    browser.press keys  ${dropdown}  ARROW_DOWN  ENTER
#Set Global Variable
#    [Arguments]    ${variable_name}    ${value}
#    Set Global Variable    ${variable_name}    ${value}

edit tools
    [Arguments]  ${labelName}
    click  //a[text() = "${labelName}"]
    click  ${tooledit}
    ${randomnewlabel}=  generate random string  5  [NUMBERS]
    Clear Text      ${label}
    Fill Text   ${label}   ${randomnewlabel}
    Clear Text   ${multiplier}
    Fill Text    ${multiplier}  ${editToolsData}[1]
    click  ${toolsSubmit}
    i should see text on page  Tool Details Edited Successfully
    open tools page
    Reload
    tools should be added  ${randomnewlabel}
    click   //a[text() = "${randomnewlabel}"]/../../../../../../../../../td[5]//button
    click  ${deactivate_downtime}
    i should see text on page  Tool deactivated successfully
