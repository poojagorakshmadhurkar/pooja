*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library    Browser

#*** Variables ***
#@{DowntimeData}  Main_powerCut09       #change name here

*** Test Cases ***
downtime creation
    login devsite
    select site  testingsiteautomation
    open downtime page
    sleep  1
    click  //button[text() = "NEW"]
    ${randomdowntime}=  generate random string  5-8  [LETTERS]
    input  ${downtimeName}  ${randomdowntime}
    enters downtime tags  P2
    select option from dropdown using div   ${downtimeDepartment}  Planning
    select option from dropdown using div  ${downtimeSeverity}  Medium
    select option from dropdown using div  ${downtimeBlame}  Machine
    select option from dropdown using div  ${downtimeNature}  Mechanical
    click  ${Submit}
    i should see text on page  Issue added
    sleep  1
    click  ${back}
    Reload
    sleep  1
    click  ${allIssues}
    downtime should be added  ${randomdowntime}
    edit downtime  ${randomdowntime}
