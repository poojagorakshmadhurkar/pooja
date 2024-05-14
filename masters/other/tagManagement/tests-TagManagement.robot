*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{tagsMangementData}  tagsMangement_test7

*** Test Cases ***
open tagsMangement page
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open tagsMangement page
    click  ${addNewtagsMangement}
    select option from dropdown using list  ${tagType}  General
    input  ${tagLabel}  ${tagsMangementData}[0]
#    select option from dropdown using list  ${tagSites}  Haridwar Unit
#    sleep  1
#    press keys  ${tagSites}  Smart Factory  ESC
#    sleep  1
    click  ${Submit}
    i should see text on page  Tag Created Successfully
#    select site  Haridwar Unit
    open tagsMangement page
    reload page
    sleep  2
    tagsMangement should be added  ${tagsMangementData}[0]

