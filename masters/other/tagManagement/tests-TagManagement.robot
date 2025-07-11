*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  Browser

#*** Variables ***
#@{tagsMangementData}  tagsMangement_test7

*** Test Cases ***
open tagsMangement page
    login devsite
    open tagsMangement page
    Wait For Elements State    //h5[normalize-space()='tags']   visible  timeout=120s
    sleep  1
    click  ${addNewtagsMangement}
    select option from dropdown using list  ${tagType}  General
    ${randomTagName}=  Generate Random Tagnmanagement Name
    Fill Text    ${tagLabel}  ${randomTagName}
#    select option from dropdown using list  ${tagSites}  Haridwar Unit
#    sleep  1
#    press keys  ${tagSites}  Smart Factory  ESC
#    sleep  1
    click  ${tagSubmit}
    i should see text on page  Tag Created Successfully
#    select site  Haridwar Unit
    open tagsMangement page
    Reload
    tagsMangement should be added  ${randomTagName}

