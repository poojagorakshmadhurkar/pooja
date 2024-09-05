*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot

*** Variables ***
@{EditDowntimeData}  Powercut34  Admin  High  Material  Electronic    #Change first name

*** Keywords ***
open downtime page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersDowntime}

downtime should be added
    [Arguments]  ${downtimeName}
    click  //button[@id='downtime__filterBtn']//*[name()='svg']
    sleep  3
    press keys  //input[@id='label']  CTRL+A  BACKSPACE
    sleep  3
    input  //input[@id='label']   ${downtimeName}
    wait until page contains element  //a[text() = "${downtimeName}"]  timeout=15s


edit downtime
    [Arguments]  ${oldDowntimeName}
    click  //a[text() = "${oldDowntimeName}"]
    click  ${Edit}
    sleep  1
    Press keys  ${downtimeName}  CTRL+A  BACKSPACE
    ${randomnewdowntime}=  generate random string  5-8  [LETTERS]
    input  ${downtimeName}  ${randomnewdowntime}
    #select option from dropdown  ${downtimeTags}  ${newDowntimeTags}
    select option from dropdown using list  ${downtimeDepartment}  ${EditDowntimeData}[1]
    select option from dropdown using list  ${downtimeSeverity}  ${EditDowntimeData}[2]
    select option from dropdown using list  ${downtimeBlame}  ${EditDowntimeData}[3]
    select option from dropdown using list  ${downtimeNature}  ${EditDowntimeData}[4]
    click  ${Submit}
    sleep  3
    i should see text on page  Issue edited
    open downtime page
    reload page
    sleep  4
    click  ${allIssues}
    downtime should be added  ${randomnewdowntime}
    click  ${deactivate_downtime}
    Click  ${deactivate_button}
    i should see text on page  Issue deactivated successfully


