*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{DowntimeData}  Main_powerCut09       #change name here

*** Test Cases ***
downtime creation
    login
    select site  smart_factory
    open downtime page
    click  //button[text() = "NEW"]
    input  ${downtimeName}  ${DowntimeData}[0]
    sleep  1
    click  ${downtimeTags}
    sleep  1
    click  //span[text()="150-III"]
    press keys  ${downtimeTags}  TAB
    select option from dropdown using list  ${downtimeDepartment}  Planning
    sleep  1
    select option from dropdown using list  ${downtimeSeverity}  Medium
    sleep  1
    select option from dropdown using list  ${downtimeBlame}  Machine
    sleep  1
    select option from dropdown using list  ${downtimeNature}  Mechanical
    sleep  1
    click  ${Submit}
    i should see text on page  Issue added
    click  ${back}
    reload page
    sleep  5
    click  ${allIssues}
    downtime should be added  ${DowntimeData}[0]

downtime edition
    edit downtime  ${DowntimeData}[0]


delete edited downtime
    delete downtime  ${EditDowntimeData}[0]