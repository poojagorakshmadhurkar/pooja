*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    FakerLibrary
Resource  ../../keywords.robot

#*** Variables ***
#@{labelName}  labelName18  1     #change name here
#@{editToolsData}  editLabel19  1  editPart3      #change name here

*** Test Cases ***
tools creation
    login
    select site  smart_factory
    open tools page
    click  ${addNewTools}
    sleep  20
##    ${randomLabel}=  generate random string  5-10  [LETTERS]
#    ${randomLabel}  FakerLibrary.Generate Random Data  name
#    Log    Random Name: ${random_name}
#    Set Global Variable    ${saved_name}    ${random_name}
#    Log    Saved Name: ${saved_name}
    input  ${label}  ${labelName}[0]
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
    Sleep  5
    select option  ${toolCTR}
    sleep  5
    select option  ${machineGroupTags}
    select option  ${itemGroupTags}
    select option  ${processTags}
    click  ${Submit}
    i should see text on page  Tool Details Added Successfully
    open tools page
    reload page
    sleep  2
    tools should be added  ${labelName}[0]

tools edition
    edit tools  ${labelName}[0]


delete edited tools
    delete tools  ${editToolsData}[0]
