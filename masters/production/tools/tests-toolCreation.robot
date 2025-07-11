*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    FakerLibrary
Resource  ../../keywords.robot
Library    Browser

*** Variables ***
@{labelName}  labelName18  1     #change name here
@{editToolsData}  editLabel19  1  editPart3      #change name here

*** Test Cases ***
tools creation
    login devsite
    open tools page
    sleep  2
    click  ${addNewTools}
    ${randomlabel}=  generate random string  5  [NUMBERS]
    Fill Text      ${label}  ${randomlabel}
    ${randomMultiplier}=  generate random string  1  [NUMBERS]
    Fill Text      ${multiplier}  ${labelName}[1]
    click  ${Addlifetime}
    ${randomLifetime}=  generate random string  1  [NUMBERS]
    Fill Text      ${lifetime}  ${labelName}[1]
    ${randomMaintenanceCycle}=  generate random string  1  [NUMBERS]
    Fill Text      ${maintenanceCycle}  ${labelName}[1]
    click  (//div[text()="Submit"])[2]
    click  ${toolsSubmit}
    i should see text on page  Tool Details Added Successfully
    open tools page
    Reload
    tools should be added  ${randomlabel}
    edit tools  ${randomlabel}



