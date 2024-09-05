*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    FakerLibrary
Resource  ../../keywords.robot

*** Variables ***
@{labelName}  labelName18  1     #change name here
@{editToolsData}  editLabel19  1  editPart3      #change name here

*** Test Cases ***
tools creation
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open tools page
    click  ${addNewTools}
    sleep  5
    reload page
    ${randomlabel}=  generate random string  1  [NUMBERS]
    input  ${label}  ${randomlabel}
    ${randomMultiplier}=  generate random string  1  [NUMBERS]
    input  ${multiplier}  ${labelName}[1]
    ${randomLifetime}=  generate random string  1  [NUMBERS]
    input  ${lifetime}  ${labelName}[1]
    ${randomMaintenanceCycle}=  generate random string  1  [NUMBERS]
    input  ${maintenanceCycle}  ${labelName}[1]
    ${randompartsLabel}=  generate random string  5-10  [LETTERS]
    input  ${partsLabel}  ${randompartsLabel}
    ${randomPartsLifetime}=  generate random string  1  [NUMBERS]
    input  ${partsLifetime}  ${labelName}[1]
    Sleep  10
    select option  ${toolCTR}
    sleep  5
#    select option  ${machineGroupTags}
#    select option  ${itemGroupTags}
#    select option  ${processTags}
    click  ${Submit}
    i should see text on page  Tool Details Added Successfully
    open tools page
    reload page
    sleep  2
    tools should be added  ${randomlabel}
    edit tools  ${randomlabel}



