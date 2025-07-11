*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library  Browser
Library    String
#Resource  ../../keywords.robot

*** Variables ***
@{actionData}  Production Reports
@{fieldData}  Text Field  Document Field  Date  System Entity  List Field
@{editFieldGroupsData}

*** Test Cases ***
fieldGroups creation

    Login devsite
#    select site  testingsiteautomation
    open fieldGroup page
#    click  ${addNewfieldGroups}
#    click  ${fieldGroupsAction}


#    select option from dropdown using span  ${fieldGroupsAction}  ${actionData}[0]
#    setting fields  0  ${fieldData}[0]
##    click  ${addMoreField}
##    setting fields  1  ${fieldData}[1]
##    click  ${addMoreField}
##    setting fields  2  ${fieldData}[2]
##    click  ${addMoreField}
##    setting fields  3  ${fieldData}[3]
##    click  ${addMoreField}
##    setting fields  4  ${fieldData}[4]
#    click  ${Submit}
#    i should see text on page  Custom Field added
#    open fieldGroup page
#    reload page
#    sleep  2
#    log  ${actionData}[0]
#    fieldGroup should be added  ${actionData}[0]

    edit fields  ${actionData}[0]
